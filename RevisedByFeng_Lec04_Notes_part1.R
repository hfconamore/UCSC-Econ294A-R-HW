
library(dplyr)

# From: 
#' http://genomicsclass.github.io/book/pages/dplyr_tutorial.html
#' https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html


# mammal sleep dataset
<<<<<<< HEAD
msleep <- read.csv("/Users/Feng/Google Drive/2016_Winter_Quarter/Econ294A_R_Curtis/data/mammals_sleep.csv")
=======
msleep <- read.csv("/Users/Feng/Google Drive/2016_Winter_Quarter/econ294_2015/data/mammals_sleep.csv")
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17
#' read.delim is for reading delimited files, defaulting to the TAB character for 
#' the delimiter. Notice that header = TRUE and fill = TRUE in these variants, 
#' and that the comment character is disabled.
msleep.doc <- read.delim(text = "
                         column name	Description
                         name	common name
                         genus	taxonomic rank
                         vore	carnivore, omnivore or herbivore?
                         order	taxonomic rank
                         conservation	the conservation status of the mammal
                         sleep_total	total amount of sleep, in hours
                         sleep_rem	rem sleep, in hours
                         sleep_cycle	length of sleep cycle, in hours
                         awake	amount of time spent awake, in hours
                         brainwt	brain weight in kilograms
                         bodywt	body weight in kilograms")
msleep.doc

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Verbs (single table verbs)
# each verb comes with helper functions

# dplyr-verbs	  Description
# select()	    select columns
# filter()	    filter rows
# arrange()	    re-order or arrange rows
# mutate()	    create new columns
# summarise()	  summarise values

# many verbs have helper functions. 

# More syntax
# group_by()	  allows for group operations in the “split-apply-combine” concept
#   %>%         magrettr "pipe" operator

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Select (also rename + helper functions)
# "dplyr::" indicates I want to go into the dplyr package

# select just a few columns
sleepData <- select(msleep, name, sleep_total)

#' Head() and tail() returns the first or last parts of a vector, 
#' matrix, table, data frame or function. 
head(sleepData, 10)

# use names() to get or set the names of an object.
names(msleep)

# ":" colon operator means from:to (a:b).
# select a range of columns (from genus to conservation).
sleepData <- select(msleep, genus:conservation)
head(sleepData)  # default number of returned obs is 6.

# starts_with()
# select all columns that start with certain text
sleepData <- select(msleep, starts_with("sl"))
head(sleepData) 

# combine several
sleepData <- select(msleep, 
                    name, starts_with("sl"), starts_with("vo"), awake:brainwt)
head(sleepData)


## additional options to select columns based on a specific criteria include
#' - starts_with(x, ignore.case = TRUE): names starts with string x
#' - ends_with(x, ignore.case = TRUE): Select columns that end with a character string
#' - contains(x, ignore.case = TRUE): selects all variables whose name contains string x
#' - matches(x, ignore.case = TRUE): selects all variables whose name matches the regular expression x (ie regex)
#' - num_range("x", 1:5, width = 2): selects all columns/variables (numerically) from x01 to x05.
#' - one_of("x", "y", "z"): selects variables provided in a character vector.
#' - everything(): selects all variables. (great for, select "everything else")

<<<<<<< HEAD
=======
# refer to var names by text chat/string with select_()
sleepdata <- select_(msleep, names(msleep)[1:4]) 
head(sleepdata)
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17

## rename - handy tool to rename many variable names quickly
# what's a fast way to rename columns?
head(
  rename(sleepData, species = name)
)
<<<<<<< HEAD
#' note "name" column is now "species" for the displayed returned values.
#' But the variable "name" is not renamed in the sleepData unless the rename command is 
#' assigned to something like testset <- rename().
=======
#note "name" column is now "species"
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17

# but you can also use select to rename columns
sleepData <- select(msleep, 
                    SPECIES = name, a = starts_with("sl"), starts_with("vo"), b = awake:brainwt)
head(sleepData)
#' This method indeed renames the column "name" to SPECIES, and we have columns a1,
#' a2, a3 and b1 b2.


## distinct and unique do the same job, but distinct is usually much faster than unique. 
names(msleep)
unique(msleep$genus)
distinct(select(msleep, genus)) # all the guneses, (geni?)
unique(msleep$order)
distinct(select(msleep, order)) # all the orders 
unique(msleep$vore)
distinct(select(msleep, vore))  # carni, omni, herbi, NA


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Filter
# think, subset - but much faster
?dplyr::filter

## Note warning
# hense, use dplyr::filter instead of just filter
# > library(dplyr)
# 
# Attaching package: ‘dplyr’
# 
# The following objects are masked from ‘package:stats’:
#   
#   filter, lag
# 
# The following objects are masked from ‘package:base’:
#   
#   intersect, setdiff, setequal, union


dplyr::filter(msleep, sleep_total >= 16)
filter(msleep, vore == "carni")

# comma for AND
filter(msleep, sleep_total >= 16, bodywt >= 1)
# you can also use "&"
filter(msleep, sleep_total >= 16 & bodywt >= 1)

# This is equivalent to the more verbose code in base R:
<<<<<<< HEAD
#' MIND THE COMMA IN THE END!!!!!!! the structure in the bracket is "rows",",","columns".
#' The "column" is missing, so all the columns would be returned.

=======
# MIND THE COMMA IN THE END!!!!!!!
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17
msleep[msleep$sleep_total >= 16 & msleep$bodywt >= 1, ]
#on bigger datasets, filter is very often much faster.

#' %in%: A logical vector, indicating if a match was located for each element of x: 
#' thus the values are TRUE or FALSE and never NA.
#' %in% is defined as "%in%" <- function(x, table) match(x, table, nomatch = 0) > 0


filter(msleep, order %in% c("Perissodactyla", "Primates"))
filter(msleep, order=="Perissodactyla"| order=="Primates") # same effect as previous line

filter(msleep, vore %in% c("carni",  "omni"))
filter(msleep, vore == "carni" | vore == "omni")  # same effect as previous line

# combine multiple with parentheses 
filter(msleep, (vore == "omni" & bodywt > 15) | (vore == "carni" & bodywt > 100))
# for traditional dataset_name[ ], MIND THE COMMA IN THE END!!!!!!!
msleep[(msleep$vore == "omni" & msleep$bodywt > 15) | (msleep$vore == "carni" & msleep$bodywt > 100), ]



## slice
# To select rows by position, use slice():
slice(msleep, 1:10) # return obs 1 to obs 10
slice(msleep, seq(1,100,by = 8)) # return obs 1, 9, 17,..., 81.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## pipe operator, intro
# %>% magrittr "this is not a pipe"

# we've down this already: 
sleepData <- select(msleep, name, sleep_total)
head(sleepData)

# alt with nested functions
head(
  select(msleep, name, sleep_total)
)
# nested functions gets messy (oft in reverse order)
# mult assignment gets messy

msleep %>% 
  select(name, sleep_total) %>% 
  head
# all these single-table-verbs, take data.frame as first arguement 
# pipes simple funnel the DF above/before into the following function call
#' caution - note the placement of "%>%" - before new-line, so R knows the line is yet
#' to finish, then it would wait for the next line to complete the whole command. 
#' Otherwise the code "msleep" would just return the whole dataset.

# equivalent is:
testdata <- msleep %>% select(name, sleep_total)
head(testdata)
#' The functions work via simple substitution so that 
#' x %>% f(y) is translated into f(x, y).


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Arrange
# think, sort/order in base-R
msleep %>% arrange(order) %>% head(25)
# arrange msleep, such that the order column is in order A -> Z
# default for char-string, a -> z

## arrange with multiple columns
#' If you provide more than one column name, each additional column 
#' will be used to break ties in the values of preceding columns.
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  head(35)
# note, within same 'order', 'sleep_total' is sorted
# default for numeric, lo -> hi

# ex with filter
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  filter(sleep_total >= 16)
# "filter" line could be insert to before "select" or befor "arrange" to yield the same result.


## descending order - desc() helper function
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, desc(sleep_total)) %>% 
  filter(sleep_total >= 16)

## or use the '-' sign with numerics
# only works on numerics !!!!!!!!!!!!!!!!
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, -sleep_total) %>% 
  filter(sleep_total >= 16)

# '-' on factor or char, not so good
msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(-order, sleep_total) %>% 
  filter(sleep_total >= 16)

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(desc(order), sleep_total) %>% 
  filter(sleep_total >= 16)

## realtive to base r
# It’s a straighforward wrapper around order() that requires less typing. 
# The previous code is equivalent to:
# it's often faster
head(msleep[order(msleep$order), ])
head(msleep[order(msleep$order, msleep$sleep_total), ])


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## mutate
# The mutate() function will add new columns to the data frame.

msleep %>% 
  mutate(
    rem_proportion = sleep_rem / sleep_total
    ) %>%
  select(name:order, sleep_total, sleep_rem, rem_proportion) %>%
  head(25)
  
# you can add many new columns
msleep %>% 
  mutate(
    rem_proportion = sleep_rem / sleep_total, 
    bodywt_grams = bodywt * 1000
    ) %>%
  select(name:order, sleep_total, sleep_rem, rem_proportion, bodywt, bodywt_grams) %>%
  head(25)

# realative to base R
# just like `transform`
msleep %>% 
  transform(
    rem_proportion = sleep_rem / sleep_total, 
    bodywt_grams = bodywt * 1000
  ) %>%
  select(name:order, sleep_total, sleep_rem, rem_proportion, bodywt, bodywt_grams) %>%
  head(25)

<<<<<<< HEAD
#BUT!, mutate lets you refer to recently created columns
msleep %>% 
  transform(
    rem_proportion = sleep_rem / sleep_total, 
    rem_proportion = rem_proportion - 100    # this line won't work
=======
#BUT!, mutate let's you refer to recently created columns
msleep %>% 
  transform(
    rem_proportion = sleep_rem / sleep_total, 
    rem_proportion = rem_proportion - 100
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17
  ) %>%
  select(name:order, sleep_total, sleep_rem, rem_proportion) %>%
  head(25)
 # nope

msleep %>% 
  mutate(
    rem_proportion = sleep_rem / sleep_total, 
    rem_proportion = rem_proportion - 100
  ) %>%
  select(name:order, sleep_total, sleep_rem, rem_proportion) %>%
  head(25)

## transmute
# you may want to keep only your new variables, use transmute
msleep %>%
  transmute(
    rem_proportion = sleep_rem / sleep_total,
    bodywt_grams = bodywt * 1000
  )

## your own functions
<<<<<<< HEAD
# both summarize and mutate allow you to implement your own functions
=======
# both summarize and mutate allow you to implement your own functinos
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17
stndz <- function(x){
  (x - mean(x, na.rm = T))  /  sd(x, na.rm = T)
}

msleep %>% 
  mutate(
    sleep_stndz = stndz(sleep_total)
  ) %>%
  select(name:order, sleep_total, sleep_stndz)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Summarize (or summarise, because the british commonwealth)

msleep %>% 
  summarise(
    sleep_avg    = mean(sleep_total)
    )

# do multiple
msleep %>% 
  summarise(
    sleep_min    = min(sleep_total),
    sleep_1stQnt = quantile(sleep_total, 0.25),
    sleep_avg    = mean(sleep_total),
    sleep_3rdQnt = quantile(sleep_total, 0.75),
    sleep_max    = max(sleep_total)
  )

# helper function, length
msleep %>% 
  summarise(
    sleep_min    = min(sleep_total),
    sleep_1stQnt = quantile(sleep_total, 0.25),
    sleep_avg    = mean(sleep_total),
    sleep_3rdQnt = quantile(sleep_total, 0.75),
    sleep_max    = max(sleep_total),
    sleep_count  = n()  #handy, short
  )


# beware: 
msleep %>% 
  summarise(
    sleep_summary = summary(sleep_total)
  )
# the func you apply must be vector of length 1 (or length 0)
<<<<<<< HEAD
# Error: expecting result of length one, got : 6   ???
=======
>>>>>>> 18c8835194cb5c6fdbcce6e13fef2b086042de17


## Summarize helper functions
# - n(): the number of observations in the current group
# - n_distinct(x): the number of unique values in x.
# - first(x),  last(x),  nth(x, n) - 
#                 these work similarly to x[1], x[length(x)], and x[n] 


## your own functions
# both summarize and mutate allow you to implement your own functinos
mean.geom <- function(x){  (prod(x))^(1 / length(x)) }
msleep %>% 
  summarise(
    sleep_mean.arth = mean(sleep_total),
    sleep_mean.geom = mean.geom(sleep_total)
  )

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Pause for review

# select(), filter(), arrange(), mutate(), summarize()

#' You may have noticed that the syntax and function of 
#' all these verbs are very similar:
#' - The first argument is a data frame.
#' - The subsequent arguments describe what to do with the data frame. 
#' Notice that you can refer to columns in the data frame directly without using $.
#' - The result is a new data frame

# Curtis has stuff to read

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Group_by
# grouped operations 

msleep %>%
  group_by(order) %>%               
  summarise(
    avg_sleep = mean(sleep_total),
    min_sleep = min(sleep_total), 
    max_sleep = max(sleep_total),
    total = n()
  )
#' 1. - we split the complete dataset into individual planes 
#' 2. and then summarise each plane by 
#' - computing the average sleep (avg_sleep = mean(sleep_total))
#' - min sleep (min_sleep = min(sleep_total))
#' - max sleep max_sleep = max(sleep_total)
#' - and counting the number of species in each group (count = n()) 
#' 3. and then recombine these into a single DF

## Group by multiple 
#' When you group by multiple variables, 
#' each summary peels off one level of the grouping. 
#' That makes it easy to progressively roll-up a dataset

msleep %>%
  group_by(vore, order) %>%               
  summarise(
    avg_sleep = mean(sleep_total),
    min_sleep = min(sleep_total), 
    max_sleep = max(sleep_total),
    total = n()
  ) %>% 
  View

# note with group_by + summarize:
# 1. first two columns will be the "group by" columns
# 2. followed by the summarize columns


## Group_by + Mutate also works
stndz <- function(x){
  (x - mean(x, na.rm = T))  /  sd(x, na.rm = T)
}

msleep %>% 
  group_by(vore, order) %>%   
  mutate(
    sleep_stndz = stndz(sleep_total),
    count       = n()
  ) %>%
  select(name, genus, vore, order, sleep_stndz, count)
# now, sleep_stndz is the sleep-time standardized over just this group 

# for example
msleep %>% 
  group_by(vore, order) %>%   
  mutate(
    sleep_stndz = stndz(sleep_total),
    sleep_mean  = mean(sleep_total)
  ) %>%
  select(name, genus, vore, order, sleep_total, sleep_mean, sleep_stndz) %>%
  dplyr::filter(order == "Carnivora")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Chaining - the power of %>%
# piping revisited

# consider: 
msleep %>%
  group_by(vore, order) %>%               
  summarise(
    avg_sleep = mean(sleep_total),
    min_sleep = min(sleep_total), 
    max_sleep = max(sleep_total),
    total = n()
  )

# nesting functions: 
summarise(
  group_by(
    msleep,
    vore, order
  ),
  avg_sleep = mean(sleep_total),
  min_sleep = min(sleep_total), 
  max_sleep = max(sleep_total),
  total = n()
)
# it works, but notice how confusing the ordering is? 
# magrittr helps tell a clear story

msleep.1 <- group_by(msleep, 
                     vore, order)
msleep.2 <- summarise(
  msleep.1,
  avg_sleep = mean(sleep_total),
  min_sleep = min(sleep_total), 
  max_sleep = max(sleep_total),
  total = n()
)
msleep.2
# perhaps create wasted objects
# perhaps less clear
# more typing

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## sample_n() and sample_frac()
? sample_n() # sample from DF of size n
# sample_frac() same from DF of proportion of original 

# useful for: 
#' - like head, check df out
#' - test some set of code on portion of larger df
#' - bootstrapping 

msleep %>% sample_n(10)
msleep %>% sample_n(10)
msleep %>% sample_n(150, replace = T) %>%
  select(genus:brainwt) #for bootstrapping

msleep %>% sample_frac(0.1)
msleep %>% sample_frac(0.5)
msleep %>% sample_frac(2, replace = T) %>% 
  select(genus:brainwt) #bootstrapping


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
## Good style
# Unless small, trivial code
# 0. start with initial `DF %>%`
# 1. each function call leads to new line. 
# 2. unless single argument, each argument (sep by comma) gets new line
# 3. use ctrl+i RStudio intentation

# not so great: 
group_by(msleep,order) %>%
  summarise(avg_sleep = mean(sleep_total), 
            min_sleep = min(sleep_total), 
            max_sleep = max(sleep_total),
            total = n())

# go with: 
df.nu <- msleep %>%
  group_by(order) %>%               # one line arg
  summarise(
    avg_sleep = mean(sleep_total),  # multiple lines for each arg 
    min_sleep = min(sleep_total),   # line up equal signs
    max_sleep = max(sleep_total),
    total = n()
  )
# ceartes clearly separated blocks
# indentation clearly links blocks to appropriate functions
# show ctrl+i

