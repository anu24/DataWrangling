library(dplyr)

# load "titanic_original.csv" data
titan <- read.csv("titanic_original.csv", header = T)

# 1. The embarked column has one missing value, find and replace with "S"
titan[titan$embarked == "", ]
titan <- titan %>% mutate(embarked = replace(embarked, embarked=="" & name != "", "S"))

# 2. "Age" column missing values
table(is.na(titan$age))

mean_age <- titan$age %>% mean(na.rm = T)
titan <- titan %>% mutate(age = replace(age, is.na(age), mean_age))

# 3. "lefeboat"
nrow(titan[titan$boat == "", ])
titan <- titan %>% mutate(boat = replace(boat, boat == "", NA))
table(is.na(titan$boat))

# 4. "cabin number"
titan <- titan %>% mutate(has_cabin_number = ifelse(cabin == "", 0, 1))
names(titan)

# 5. Write cleanedup data to "titanic_clean.csv"
write.csv(titan, "titanic_clean.csv")
