
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
print("Feng Hong")
print(1505026)
print("fehong@ucsc.edu")

library(foreign)
library(ggplot2)
library(dplyr)
library(scales)


##################### 1a
q1_a <- ggplot(
  data = diamonds,
  aes(x = x*y*z,
      y= price,
      size = carat, 
      color = clarity
      )
) 
q1_a + geom_point(alpha = 0.2) + scale_x_log10() + scale_y_log10()



##################### 1b
q1_b <- ggplot(diamonds, aes(x = carat, fill=clarity)) 
q1_b + geom_histogram(aes(y = ..density..), bins=25) + facet_grid(cut ~ .) + xlab("Carat") + ylab("Density") + guides(fill = guide_legend(title = "Clarity")) 
        
        
        
##################### 1c
q1_c <- ggplot(diamonds, aes(x = cut, y = price))
q1_c + geom_violin() + geom_jitter(alpha=0.01)


##################### 2a
org_example <- read.dta("/Users/Feng/Google Drive/2016_Winter_Quarter/Econ217/217 Data File/org_example.dta")

q2a_data <- org_example %>%
  group_by(year, month) %>%
  summarise(
    Median.RW = median(rw, na.rm = T),
    rw.10 = quantile(rw, 0.1, na.rm = T),
    rw.25 = quantile(rw, 0.25, na.rm = T),
    rw.75 = quantile(rw, 0.75, na.rm = T),
    rw.90 = quantile(rw, 0.9, na.rm = T)
  ) %>%
  mutate(
    date = paste(year, month, "01", sep = "-"),
    date = as.Date(date, format = "%Y-%m-%d")
  )

q2_a <- ggplot(q2a_data, aes(x = date, y = Median.RW)) 

q2_a + geom_line(size = 0.8) + geom_ribbon(aes(ymin = rw.25, ymax = rw.75), alpha =0.5) + 
geom_ribbon(aes(ymin = rw.10, ymax = rw.90), alpha = 0.2) + ylim(0, 50)


##################### 2b
q2b_data <- org_example %>%
   group_by(year, month, educ) %>%
   summarise(Median.RW = median(rw, na.rm = T)) %>%
   mutate(
     date = paste(year, month, "01", sep = "-"),
     date = as.Date(date, format = "%Y-%m-%d")
   )

q2_b <- ggplot(q2b_data, aes(x = date, y= Median.RW, fill = educ))
q2_b + geom_line(aes(color = educ), size = 0.8)


