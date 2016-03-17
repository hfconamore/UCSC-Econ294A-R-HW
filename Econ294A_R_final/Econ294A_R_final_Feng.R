############# Econ294A R programming final ##############

library(Rcpp)
library(ggplot2)
library(gridExtra)
library(dplyr)
library(class)
library(nycflights13)  #for data
library("RSQLite") #for sqllite


####################### raw data ########################
nycflights13_sqlite()

flights_sqlite <- tbl(nycflights13_sqlite(), "flights")
airlines_sqlite <- tbl(nycflights13_sqlite(), "airlines")
airports_sqlite <- tbl(nycflights13_sqlite(), "airports")
planes_sqlite <- tbl(nycflights13_sqlite(), "planes")
weather_sqlite <- tbl(nycflights13_sqlite(), "weather")


#################### join flights and planes data, then refine ###########

# join the table flights and planes
inner_flights_planes <- inner_join(flights, planes, by = "tailnum") %>% tbl_df 
names(inner_flights_planes)
colnames(inner_flights_planes)[1] <- "flight_year"
colnames(inner_flights_planes)[15] <- "dep_hour"
colnames(inner_flights_planes)[17] <- "plane_year"

# create the date index
inner_flights_planes <- inner_flights_planes %>% 
  mutate(
    date = paste(flight_year, month, day, sep = "-"), 
    date = as.Date(date, format = "%Y-%m-%d"), # create date to merge with weather
    cancelled = ifelse(is.na(arr_time), 1, 0)  # question requires this
  ) 

# select columns needed from the inner_flights_planes dataset
flights_planes <- inner_flights_planes %>%
  dplyr::select(
    cancelled, date, month, day, dep_hour,
    dep_time, dep_delay, arr_time, arr_delay,
    carrier, flight, origin, dest, air_time, distance, 
    plane_year, manufacturer, seats)


# change character variable to factor variable
flights_planes$carrier <- as.factor(flights_planes$carrier)
flights_planes$origin <- as.factor(flights_planes$origin)
flights_planes$dest <- as.factor(flights_planes$dest)
flights_planes$manufacturer <- as.factor(flights_planes$manufacturer)

# change integer variable to factor variable
flights_planes$month <- as.factor(flights_planes$month)
flights_planes$flight <- as.factor(flights_planes$flight)


#################### refine weather data ##################
weather <- weather_sqlite %>%  
  collect() %>% 
  mutate(
    date = paste(year, month, day, sep = "-"),
    date = as.Date(date, format = "%Y-%m-%d"),
    weekday = weekdays(date),
    weekday = as.factor(weekday) # add the weekday variable
  ) 


weather_mean <- weather %>% group_by(date) %>%
  summarise(
    weekday = first(weekday),
    mean_temp = mean(temp),
    mean_dewp = mean(dewp),
    mean_humid = mean(humid),
    # mean_wind_dir = mean(wind_dir), wind direction has too many NA's.
    # mean_wind_speed = mean(wind_speed),
    # mean_wind_gust = mean(wind_gust), excluded because their effects depending on direction.
    mean_precip = mean(precip),
    # mean_pressure = mean(pressure), pressure has too many NA's.
    mean_visib = mean(visib)
  )



# identify the highly correlated data
corr_weather_mean <- cor(na.omit(weather_mean[,3:7]))
print(corr_weather_mean)

# delete columns that are highly correlated from weather_mean
weather2 <- weather_mean %>%
  dplyr::select(date, weekday, mean_temp, mean_precip, mean_visib)



#################### join flights, planes and weather data ###########

final_data <- inner_join(flights_planes, weather2, by = "date")
length(final_data[final_data$cancelled == 1])
names(final_data)




#################### linear regression ###########################
# OLS for dep_delay
model.delay <- lm(dep_delay ~ month + as.factor(weekday) + carrier + origin +
                plane_year + seats + mean_precip + mean_visib,
               data = final_data)
summary(model.delay)

# GLS for cancel
model.cancel <- glm(cancelled ~ month + as.factor(weekday) + carrier + origin +
                     seats +  mean_visib,
                   data = final_data, family=binomial(link="logit"))
summary(model.cancel)



#################### plotting ###########################
# (a) weather 
plot_weather <- ggplot(data = final_data, aes(mean_precip, mean_visib)) 
plot_weather + geom_point( aes(color = as.factor(cancelled)),size = 1) +
  xlab("Precipitation") + ylab("Visibility")


# (b) day of week and time of year
month_weekday <- final_data %>%
  group_by(month, weekday) %>%
  summarise(mean.dep_delay = mean(dep_delay, na.rm = T)) 

plot_time <- ggplot(month_weekday, aes(x = month, y= mean.dep_delay))
plot_time + geom_point(aes(color = weekday), size = 3) +
  xlab("Month") + ylab("Departure Delay")
