
# title: Assignment 2 example script. 
# author: "Feng Hong"
# date: "01/21/2016"
# assignment: https://github.com/EconomiCurtis/econ294_2015/blob/master/Assignments/Econ_294_Assignment_2.pdf
# ---


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Question 0

FengHongAssignment2 <- list(
  firstName = "Feng",
  lastName  = "Hong",
  email     = "fehong@ucsc.edu",
  studentID = 1505026
)



# Question 1

# <- get(load(...)) is a handy way to load an .RData file and rename it at the same time
diamonds <- get(  
  load(
    file = url("https://github.com/EconomiCurtis/econ294_2015/raw/master/data/diamonds.RData")
  )
)

FengHongAssignment2$s1a <- nrow(diamonds)
# There are 7 observations in the data set.
FengHongAssignment2$s1b <- ncol(diamonds)
# There are 4 columns in the data set.
FengHongAssignment2$s1c <- names(diamonds)
# The header names are "carat", "cut", "clarity", "price".
FengHongAssignment2$s1d <- summary(diamonds$price)

save(FengHongAssignment2,
     file = "/Users/Feng/Google Drive/2016_Winter_Quarter/econ294a_fehong/FengHongAssignment2.RData")


# Question 2
library(foreign)
Q2data <- read.table("https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_TSV.txt",header=TRUE)

FengHongAssignment2$s2a <- nrow(Q2data)
# There are 4785 observations in the data set.
FengHongAssignment2$s2b <- ncol(Q2data)
# There are 9 columns in the data set.
FengHongAssignment2$s2c <- names(Q2data)
#' The header names are "HHX", "FMX", "FPX", "SEX", "BMI",	
#' "SLEEP",	"educ",	"height",	"weight".
FengHongAssignment2$s2d <- mean(Q2data$weight,na.rm = T)
# The mean weight of the weight colunm is 266.
FengHongAssignment2$s2e <- median(Q2data$weight,na.rm = T)
# The median weight of the weight colunm is 175.

# The number between 996 and 999 pounds are used for denoting missing data. 
# Use ifelse to create a new column, setting these weight observations to NA.
# Note: Need to assign the ifelse result to the column rather than just run the ifelse command.
Q2data$refined_weight <- ifelse(Q2data$weight>=996 & Q2data$weight<=999, 
       Q2data$refined_weight <- NA, Q2data$refined_weight <- Q2data$weight)
Q2data$refined_weight    
summary(Q2data)

# Create a histogram of these weights 
hist(Q2data$refined_weight)
table(Q2data$refined_weight)

FengHongAssignment2$s2f <- mean(Q2data$refined_weight,na.rm = T)
# The mean weight of the adjusted weight colunm is 174.
FengHongAssignment2$s2g <- median(Q2data$refined_weight,na.rm = T)
# The median weight of the adjusted weight colunm is 170.


#' What is the summary of weights for men ($s2h, summary table, length 7) 
#' and women ($s2i, summary table, length 7)? Man = 1 and Woman = 2.
FengHongAssignment2$s2h <- summary(Q2data[Q2data$SEX == 2,]$refined_weight)
FengHongAssignment2$s2i <- summary(Q2data[Q2data$SEX == 1,]$refined_weight)







