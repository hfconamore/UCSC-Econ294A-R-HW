#' Feng Hong
#' Winter 2016


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 0 
print("Feng Hong")
print(1505026)
print("fehong@ucsc.edu")



# # # # # # # # # # # # # 11111111111111111111111 # # # # # # # # # # # # # # # 
library(foreign)
df.ex <- read.dta(
  "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/org_example.dta"
)
#loaded this way, it's a data frame
class(df.ex)


# # # # # # # # # # # # # 2222222222222222222222 # # # # # # # # # # # # # # # #
require(dplyr)
# Using %>% with unary function calls
#' x %>% f is equivalent to f(x) 
#' df.ex is the required argument in dplyr::filter() function.
# Use dplyr to subset df.ex to just the last month of 2013.

df.ex.2 <- df.ex %>%
  dplyr::filter(
    year == 2013 & month == 12
  )
print(nrow(df.ex.2))
# [1] 13261

# Print the number of observations in Summer (July, August, and Sept months) 2013. 
# use the combination of "&", "|" and "()".
df.ex.2 <- df.ex %>%
  dplyr::filter(
    year == 2013 & (month == 7 | month == 8 | month == 9)
  )
print(nrow(df.ex.2))
# [1] 39657

# # # # # # # # # # # # # # 3333333333333333333 # # # # # # # # # # # # # # # # 
# Create a new data frame called df.ex.3a that is sorted with year and month ascending.
df.ex.3a <- df.ex %>% arrange(year, month)


# # # # # # # # # # # # # # 44444444444444444444 # # # # # # # # # # # # # # # # 
# Create a new data frame called df.ex.4a with only columns year through age.
df.ex.4a <- select(df.ex, year:age)

# Create a new data frame called df.ex.4b with only columns year, month, and columns that start with i.
df.ex.4b <- select(df.ex, year, month, starts_with("i"))

# For the variable state print the distinct set of values in the original df.ex.
print(distinct(select(df.ex, state)))



# # # # # # # # # # # # # # 55555555555555555555 # # # # # # # # # # # # # # # # 

#' Create a new function called stndz that takes a vector of numbers, 
#' and returns the standard score for each element (ignoreing NAs). 


#' Create another function called nrmlz that takes a vector of numbers, and returns 
#' the feature scaled value for each element (ignoring NAs in your min() and max() calls). 
#' Feature scaling details, this function will work similar to stndz.

#' Create a new data frame called df.ex.5a with two new columns, one called rw.stndz
#' with the standardized score of real wages, and another called rw_nrmlz with feature 
#' scaled values of real wages.

# Create a new data frame called df.ex.5b with three new columns. 
#' The three new columns should reflect the standard score (rw.stndz), feature scaled
#' value (rw_nrmlz), and count at year, month groupings. 
#' (Tip1, use group_by() and n(). 
#' Tip2 to help you double check your work, In Jan 2013, 
#' the rw of 57.485714 should have rw.stndz of 2.18566760, rw_nrmlz of 0.233088223 
#' and count of 13342.)














