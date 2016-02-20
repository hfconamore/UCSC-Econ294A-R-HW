
# title: "Econ 294 Assignment 4"
# author: "Feng Hong"


library(plyr)
library(foreign)
require(tidyr)
require(dplyr)
require(plyr)  

# 0. Use a `print` call to report your first name, last name, and student ID number. 
print(c("Feng Hong","1505026"))

# 1.
flights <- read.csv("/Users/Feng/Google Drive/2016_Winter_Quarter/Econ294A_R_Curtis/data/flights.csv", stringsAsFactors=FALSE)
planes <- read.csv("/Users/Feng/Google Drive/2016_Winter_Quarter/Econ294A_R_Curtis/data/planes.csv", stringsAsFactors=FALSE)
weather <- read.csv("/Users/Feng/Google Drive/2016_Winter_Quarter/Econ294A_R_Curtis/data/weather.csv", stringsAsFactors=FALSE)
airports <- read.csv("/Users/Feng/Google Drive/2016_Winter_Quarter/Econ294A_R_Curtis/data/airports.csv", stringsAsFactors=FALSE)


# 2. Convert any `date` column from type char to type date using the `as.Date()` function. 
typeof(flights$date)
flights$date <- as.Date(flights$date)
typeof(weather$date)
weather$date <- as.Date(weather$date)


# 3. Extract all flights that match these critera: 
# Create `flights.2a`, all flights that went to the city of San Francisco or Oakland CA. 
# Print the number of observation you find.
flights.2a <- flights[(flights$dest == "SFO" | flights$dest == "OAK"), ]
print(nrow(flights.2a))
# [1] 3508

# Create `flights.2b`, all flights delayed by an hour or more. 
# Print the number of observations. 
#' I assume any record with departure delay greater than 60 minites or arrival delay greater 
#' than 60 minites satisfy the condition.
flights.2b <- flights %>% dplyr::filter(dep_delay >=60 | arr_delay >=60)
print(nrow(flights.2b))
# [1] 11920

#' Create `flights.2c`, all flights in which the arrival delay was more than twice as much 
#' as the departure delay.  Print the number of observations for this question. 
flights.2c <- flights %>% dplyr::filter(arr_delay > 2 * dep_delay)
print(nrow(flights.2c))
          
#' 4. Using `select()`'s helper functions, come up with different three ways to select the 
#' delay varaibles from `flights` (see `?dplyr::select` for details.)
flights.4_1 <- flights %>% select(dep_delay, arr_delay )
flights.4_2 <- flights %>% select(ends_with("delay"))
flights.4_3 <- flights %>% select(contains("delay"))
           
# 5. Working with `arrange()`
# 5a use arrange to find and print the top five most (departure) delayed flights. 
print(head(flights %>% arrange(desc(dep_delay)), 5))

#' 5b use arrange to find and print the top five flights that caught up the most
#' (in absolute time) during the flight. 
#' (Arrange allows you to use compound expressions, but feel free to use `mutate`.)
print(head(flights %>% arrange(desc(abs(arr_delay - dep_delay))), 5))

# 6. Working with `mutate()`.
# **Change the `flights` data frame**, by adding a number of new columns:
# Where the existing `time` variable is travel time in minutes, find `speed` in mph.
flights_s <- na.omit(flights) %>% mutate(speed = dist / (time/60))

# Create `delta`, the amount of time made-up or lost in the flight 
# (e.g. a `delta` of 60 means the flight made up 60 minutes between departure and arrival). 
flights_s_d <- na.omit(flights_s) %>% mutate(delta = dep_delay - arr_delay)

# 6a. Print the top five flights by speed. 
flights_s_d %>% arrange(-speed) %>% head(5) %>% print
           
# 6b. Print the top five flights that made up the most time in flight (this should match 5b)
flights_s_d %>% arrange(-delta) %>% head(5) %>% print

# 6c. Print the top flights that **lost** the most time in flight. 
flights_s_d %>% arrange(-(dep_delay + arr_delay)) %>% head(1) %>% print

#' 7. Working with `group_by` and `summarize`. 
#' Recall `?dplyr::summarize` maps a data frame to a single row of summary statstics you have set-up. 
#' The `group_by` function allows you to find a set of statistics within each group you define 
#' (and `ungroup()` undos `group_by()`). 
#' Grouping by carrier. Create `flights.7a` with the following summary statistics grouped by `carrier`: 
#' The number of cancelled flights by each carrier, total flights (`n()`), the percent of canceled 
#' flights relative to total flights, and from the `delta` variable (created above) find the `min`, 
#' first quartile, `median`, `mean`, third quartile, 90th quantile, and `max`. (`quantile` can find 
#' quartiles too - don't forget `na.rm = T` when referring to delta)

# TODO:
flights.7a <- flights_s_d %>%
  group_by(carrier) %>%
  dplyr::summarise(
    cancelled = sum(cancelled),
    total_flights = n(),
    delta_min = min(delta, na.rm=T),
    delta_1stQnt = quantile(delta, 0.25, na.rm = T),
    delta_median = median(delta, na.rm = T),
    delta_mean = mean(delta, na.rm = T),
    delta_3rdQnt = quantile(delta, 0.75, na.rm = T),
    delta_90Qnt = quantile(delta, 0.9, na.rm = T),
    delta_max = max(delta, na.rm = T)
  ) %>% arrange(-cancelled)

flights.7a

print("Find out the records whose dep_delay exists and group the records by dep_delay and date and summarise ")
day_delay <- flights %>%
  dplyr::filter(!is.na(dep_delay)) %>%
  group_by(dep_delay, date) %>%
  summarise(
    delay = mean(dep_delay),
    n = n()
  ) %>%
  dplyr::filter(n>10)




# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 9

dest_delay <- flights %>%
  group_by(dest) %>%
  dplyr::summarise(
    arr_delay = mean(arr_delay, na.rm = TRUE),
    num_of_flights = n()
  )

airports <- airports %>% dplyr::select(-country) %>% plyr::rename(c("iata"="dest", "airport"="name"))

# 9a
df.9a <- dest_delay %>% 
  left_join(airports, by = "dest")

df.9a %>% arrange(-arr_delay) %>% head(5)

dest_delay %>% head(5)
airports %>% head(5)

# 9b
df.9b <- dest_delay %>% 
  inner_join(airports, by = "dest")
# No, because the information in the dest column is not exactly the same, namely the airports table
# has 2 occurrences in dest column that don't exist in dest_delay, which leads to the fact that 
# inner_join produces 2 more observations than left_join

# setdiff(dest_delay %>% select(dest), airports %>% select(dest))
# dest
# (chr)
# 1   BKG
# 2   ECP

# 9c
df.9c <- dest_delay %>% 
  right_join(airports, by = "dest")
# 3376 observation are in this new table, there are a lot of NAs in arr_delay
# because airports table doesn't have the column arr_delay

# 9d
df.9d <- dest_delay %>% 
  full_join(airports, by = "dest")
# 3378 observation are in this new table, there are a lot of NAs in arr_delay
# because airports table doesn't have the column arr_delay


nrow(df.9a)
nrow(df.9b)
nrow(df.9c)
nrow(df.9d)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 10

hourly_delay <- flights %>%
  dplyr::filter(!is.na(dep_delay)) %>%
  group_by(dep_delay, date, hour) %>%
  dplyr::summarise(
    dep_delay_mean = mean(dep_delay)
  )

hourly_delay %>% 
  left_join(weather, by = c("date","hour")) %>%
  group_by(conditions) %>%
  dplyr::summarise(
    dep_delay = mean(dep_delay_mean),
    n = n()
  )

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 11a

df <- data.frame(treatment = c("a", "b"), subject1 = c(3, 4), subject2 = c(5, 6))
df %>% gather(subject, 
              ... = -treatment,
              na.rm = T) %>% 
  separate(subject, 
           c("foobar", "subject"), 
           7) %>%
  select(subject, treatment, value)

# 11b
df <- data.frame(
  subject = c(1,1,2,2),
  treatment = c("a","b","a","b"), value = c(3,4,5,6)
) 

#paste(df$subject, "subject", sep="") 
df$subject <- sub("^", "subject", df$subject)
df %>% spread(
  key = subject,
  value = value
)


# 11c
df <- data.frame(
  subject = c(1,2,3,4),
  demo = c("f_15_CA","f_50_NY","m_45_HI","m_18_DC"), value = c(3,4,5,6)
)
df %>% separate(
  demo,
  c("sex", "age", "state")
)

# 11d
df <- data.frame(
  subject = c(1,2,3,4),
  sex = c("f","f","m",NA),
  age = c(11,55,65,NA),
  city = c("DC","NY","WA",NA), value = c(3,4,5,6)
)
df2 <- df %>% unite(
  col = demo,
  ... = sex, age, city,
  sep = "."
) 
df2$demo <- replace(df2$demo, 4, NA)


