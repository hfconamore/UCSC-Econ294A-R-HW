
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
#  Pay attention to the syntax here!!!!!!!!!
FengHongAssignment2$s2h <- summary(Q2data[Q2data$SEX == 2,]$refined_weight)
FengHongAssignment2$s2i <- summary(Q2data[Q2data$SEX == 1,]$refined_weight)


# Question 3
vec <- c(letters,LETTERS)
# Extract even index values (2,4,6...) from vec ($s3a char vector, length 26)
FengHongAssignment2$s3a <- vec[seq(2,length(vec),2)]
# Use vec to extract the first three letters of your name 
FengHongAssignment2$s3b <- paste(vec[c(32,5,14)],collapse = "")

arr <- array( c(letters,LETTERS), dim = c(3,3,3) )
# Extract the first column from the second matrix of arr
FengHongAssignment2$s3c <-arr[,1,2]

# Extract the middle values from each of the three matrices in arr 
FengHongAssignment2$s3d <-arr[2,2,]

# Extracting values from arr, spell the first three letters of your first name 
FengHongAssignment2$s3e <- paste(arr[3,2,1],arr[2,2,1],arr[2,2,2], sep = "")




# Question 4
# Load Alan's org_example.dta file.
library(foreign)
org_example <- read.dta("http://people.ucsc.edu/~aspearot/Econ_217_Data/org_example.dta")
summary(org_example)

# Find average rw for each year-month-educ group. (ignore NAs)
FengHongAssignment2$s4 <- data.frame( aggregate(org_example$rw,
                        list(year = org_example$year,
                             month= org_example$month,
                             educ = org_example$educ),
                        mean,na.rm=TRUE))

# Rename the last column of the data fram.
names(FengHongAssignment2$s4)[4] <- "AverageRealWage"

save(FengHongAssignment2,
     file = "/Users/Feng/Google Drive/2016_Winter_Quarter/econ294a_fehong/FengHongAssignment2.RData")

FengHongAssignment2
