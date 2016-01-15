
firstName <- "Feng"
lastName  <- "Hong"
studentID <- "1505026"

print(
  paste(firstName,lastName,studentID)
)

# Question 1
library(foreign)

# From .dta (STATA File). Assign the name df.dta to the file.
# mind that ".dta", ".csv", ".td" are not file suffix but just part of the variable name.
df.dta <- read.dta(
  file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_dta.dta"
)

# From CSV. Assign the name df.csv to the file.
df.csv <- read.csv(
  file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_CSV.csv"
)

# From Tab deliniated. Assign the name df.td to the file.
df.td <- read.table(
  file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_TSV.txt"
)

# From .RData.
df.rdata <- load(url("https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_RData.RData"))
df.rdata
# [1] "NHIS_2007_RData"
# .RData files come with names already assigned to their data structures. 
# The name assigned to this .RData file is still the original name "NHIS_2007_RData".

# Notes: Reading the documentation using the load() function works differently than the read.... functions. 
# where the read... functions create a data.frame, which you assign to a name, 
# load just opens an R object that already has a name. 


#Question 2
# Download each file above to your hard drive, how big (in KB) is each file? 
# 192K	NHIS_2007_dta.dta
# 142K	NHIS_2007_CSV.csv
# 142K	NHIS_2007_TSV.txt
# 46K	  NHIS_2007_RData.RData

# Which is the smallest? Besides the .dta file, what accounts for their variability?
# .RData is the smallest one. .csv and .txt are about the same size because they contain same 
# information, while .RData file is compressed and optimized.


# 3. For the object df.rdata, what typeof and class of this data structure?
setwd("/Users/Feng/Google Drive/2016_Winter_Quarter/econ294_2015/data")
typeof(NHIS_2007_RData)
# [1] "list"
class(NHIS_2007_RData)
# "data.frame"

# Apply and report length, dim, nrow, ncol, and summary functions.
print(length(NHIS_2007_RData))
# [1] 9
print(dim(NHIS_2007_RData))
# [1] 4785    9
print(nrow(NHIS_2007_RData))
# [1] 4785
print(ncol(NHIS_2007_RData))
# [1] 9
summary(NHIS_2007_RData)


# 4. Load org_example.dta Stata file from the URL below, and assign the name df to the loaded object.
df.dta <- read.dta(
  file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/org_example.dta"
)
print(str(df.dta))
# How many observations and how many variables are there?
# There are 1119754 observations and 30 variables.

# For the variable (column) rw what is the min, mean, median, max, first and third quartile value?
min(df.dta$rw,na.rm = TRUE)
# [1] 1.814375
mean(df.dta$rw,na.rm = TRUE)
# [1] 19.81418
median(df.dta$rw,na.rm = TRUE)
# [1] 15.87578
max(df.dta$rw,na.rm = TRUE)
# [1] 354.8014
quantile(df.dta$rw, c(.25, .75),na.rm = TRUE) 
#     25%      75% 
# 10.70473 24.35870 

#' How many NAs are there? Use 2 ways to solve the problem:
summary(df.dta)
sum(is.na(df.dta$rw))
# 521279 observations have the value NA in the row rw.


# 5.Create the a vector named v with {1,2,3,4,5,6,7,4,NULL,NA}
v <- c(1,2,3,4,5,6,7,4,NULL,NA)
print(length(v))
# [1] 9
# For vectors the length is the number of elements and NULL has length 0. 
# So the returned value is 9 rather than 10.
print(mean(v,na.rm = TRUE))       # Report mean ignoring the NA value
# [1] 4


# 6.Matrix operations
# Create a matrix and call it x.
# Resource: http://www.r-tutor.com/r-introduction/matrix/matrix-construction
x = matrix(c(1,4,7,2,5,8,3,6,9), nrow=3, ncol=3)
View(x)
# Alternative solution: http://statistics.berkeley.edu/computing/r-vectors-matrices
x = matrix(1:9,ncol=3,byrow=T)
View(x)

# Show how to find its transpose.
t(x)

# Find the eigenvalues and eigenvectors of x.
eigen_value_vector <- eigen(x)
eigen_value_vector

# Create another matrix and call it y.
y <- matrix(c(1,2,3,3,2,1,2,3,0), nrow=3, ncol=3,byrow = T)
View(y)

# Another way: use data frame https://stat.ethz.ch/R-manual/R-devel/library/base/html/data.frame.html
a1 <- c(1, 3, 2)
a2 <- c(2, 2, 3)
a3 <- c(3, 1, 0)
aframe = data.frame(a1, a2, a3)
y = matrix(as.matrix(aframe),nrow=3, ncol=3)
View(y)

# http://www.statmethods.net/advstats/matrix.html
y_inverse = solve(y)
print(y %*% y_inverse)
# From linear algebra, this new matrix called identity matrix.
#          [,1]      [,2] [,3]
#[1,]  1.000000e+00    0    0
#[2,]  0.000000e+00    1    0
#[3,] -5.551115e-17    0    1


# 7.Create a data frame, called diamonds.
carat = c(5,2,0.5,1.5,5,NA,3)
cut = c("fair","good","very good","good","fair","Ideal","fair")
clarity = c("SI1","I1","VI1","VS1","IF","VVS2",NA)
price = c(850, 450,450, NA, 750, 980, 420)
diamonds <- data.frame(carat,cut,clarity,price, row.names = NULL, check.rows = FALSE,
           check.names = TRUE,
           stringsAsFactors = default.stringsAsFactors())

# What is the mean price?
print(mean(diamonds$price,na.rm = TRUE))

# What is the mean price of cut "good", "very good", and "Ideal"?
print(mean(diamonds$price,na.rm = TRUE))

# What is the mean price of cut “fair”?
mean(diamonds[diamonds$cut=="fair",]$price,na.rm = TRUE)

# What is the mean price of cut “good”, “very good”, and “Ideal”?
mean(diamonds[diamonds$cut=="good"|diamonds$cut=="very good"|
                diamonds$cut=="Ideal",]$price,na.rm = TRUE)

# For diamonds with greater than 2 carats, and cut “Ideal” or “very good”, 
# what is the median price?
median(diamonds[diamonds$carat>2 & (diamonds$cut=="Ideal" | diamonds$cut=="very good"),]$price,na.rm = TRUE)
# None of this kind of data exists




