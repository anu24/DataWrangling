'# In this exercise, will work with a toy data set showing product purchases from 
an electronic#'

library(dplyr)

# Load "refine_original.csv" data
toy <- read.csv("refine_original.csv", header = T)

# 1. Clean up brand name to (philips, akzo, van houten and unilever) 
head(toy)
company_name <- toy$company
# Using regular expression
company_name <- gsub(pattern = "^[p,P].*[s,S]$", replacement = "philips", company_name)
company_name <- gsub(pattern = "^[f,F].*", replacement = "philips", company_name)
company_name <- gsub(pattern = "^[a,A].*", replacement = "akzo", company_name)
company_name <- gsub(pattern = "^[V,v].*", replacement = "van houten", company_name)
company_name <- gsub(pattern = "^[U,u].*", replacement = "unilever", company_name)
toy$company <- company_name

# 2. Separate the product code and number
toy$product_code <- substr(toy$Product.code...number, 1, 1)
toy$product_number <- substr(toy$Product.code...number, 3, 6)

# 3. Add product categories
pc <- c(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")
toy$categoris <- pc[toy$product_code]

# 4. Add full address geocoding (address, city, country)
toy$full_address <- paste(toy$address, toy$city, toy$country, sep = ", ")
names(toy)

# 5.Create dummy variables for company and product category
com_dummy <- model.matrix(~company-1, toy)
com_dummy <- as.data.frame(com_dummy)
toy <- cbind(toy, com_dummy)

pro_dummy <- model.matrix(~categoris-1, toy)
pro_dummy <- as.data.frame(pro_dummy)
toy <- cbind(toy,pro_dummy)
names(toy)

# renaming column represents dummies of Company & Category
colnames(toy)[11:14] <- c("company_akzo", "company_philips", "company_unilever", "company_van_houten")
colnames(toy)[15:18] <- c("product_smartphone", "product_tv", "product_laptop", "product_tablet")

toy_tbl <- tbl_df(toy)
toy_tbl
