# Lau Wan Jing, P20012339, 5011CEM Big data programming project

################################################################################

# Comparison between Parallel and Sequential Processing

# Using parallel package
install.packages("parallel")

# Using microbenchmark to compare the two processing
install.packages("microbenchmark")

# Using ggplot2 to visualize data
install.packages("rlang")
install.packages("ggplot2")

# Set working directory
setwd("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET")

# Load parallel library
library(parallel)

# Detect number of cores that could run the program
detectCores()

# Load microbenchmark library
library(microbenchmark)

# Sequential processing, lapply

# Assign the path of the data set
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"

# Add together as a files list
filenames <- list.files(path, pattern = "*.csv")

# Show the current file names
filenames

# Execute lapply function and assign into a variable
lapply_function <- lapply(filenames,FUN = function(i){
  read.csv(i, header=TRUE, skip=4)
})

# Parallel processing, parLapply

# Assign the path of the data set
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"

# Add together as a files list
filenames <- list.files(path, pattern = "*.csv")

# Show the current file names
filenames

# Assign the cluster that made based on the number of cores in computer
cl <- makeCluster(detectCores())

# Execute parLapply function and assign it into a variable
parLapply_function <- parLapply(cl, filenames,fun = function(i){
  read.csv(i, header=TRUE, skip=4)
})

# Stop the cluster that started just now
stopCluster(cl)

# Comparison between lapply and parLappply function with the two variables, carry out both function in one time using microbenchmark
compare <- microbenchmark(lapply_function,
                          parLapply_function,
                          times = 1)

# Print compare output
compare

# Load the ggplot2 library
library(ggplot2)

# Assign the compare output into a data frame
df <- data.frame(compare)
head(df)

# Plot output
p <- ggplot(data=df, aes(x=expr, y=time)) + geom_bar(stat="identity")

# Print output of the plot
p

################################################################################

# Finalize data set

# Combining multiple csv files
install.packages("dplyr")
library(dplyr)
library(readr)

# Import and merge three targeted CSV files
file1 <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_borough_grocery.csv"
file2 <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_msoa_grocery.csv"
file3 <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_osward_grocery.csv"

# Make into a list
files <- list(file1, file2, file3)

# Use lapply to bind them together
df <- files %>% 
  lapply(read_csv) %>% 
  bind_rows

# View resulting data frame
df %>% data.frame

# View all rows or columns
df %>% print(n=Inf)
df %>% print(width=Inf)

# Keep the targeted columns: product calories, average age and number of transactions
data = subset(df, select = c(energy_density, avg_age, num_transactions))

# Show the data
data

# Print all rows
data %>% print(n=Inf)

# Data cleaning
install.packages("janitor")
library(janitor)
library(dplyr)

# round up the digits of the data
round(data, digits = 3)

# handle NA rows and columns
data<-data %>% remove_empty(whic=c("rows"))
data<-data %>% remove_empty(whic=c("cols"))

# Change the columns name
colnames(data) <- c("Product_calories", "Average_age","Number_of_transactions")

# Structure the data
str(data)
data %>% print(n=Inf)

# Export csv
write.csv(data,"C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/FinalDataset.csv", row.names = FALSE)
write.csv(df,"C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/FinalCombiningDataset.csv", row.names = FALSE)

################################################################################

# Descriptive Analysis

# minimum, maximum of product calories
min(data$Product_calories)
max(data$Product_calories)

# minimum, maximum of average age
min(data$Average_age)
max(data$Average_age)

# minimum, maximum of number of transactions
min(data$Number_of_transactions)
max(data$Number_of_transactions)

# mean of product calories, average age and number of transactions
mean(data$Product_calories)
mean(data$Average_age)
mean(data$Number_of_transactions)

# median of product calories, average age and number of transactions
median(data$Product_calories)
median(data$Average_age)
median(data$Number_of_transactions)

# first and third quartile of product calories, average age and number of transactions
quantile(data$Product_calories, 0.25)
quantile(data$Product_calories, 0.75)

quantile(data$Average_age, 0.25)
quantile(data$Average_age, 0.75)

quantile(data$Number_of_transactions, 0.25)
quantile(data$Number_of_transactions, 0.75)

# interquartile range of product calories, average age and number of transactions
IQR(data$Product_calories)
IQR(data$Average_age)
IQR(data$Number_of_transactions)

# standard deviation, variance and range
sd(data$Product_calories)
sd(data$Average_age)
sd(data$Number_of_transactions)

var(data$Product_calories)
var(data$Average_age)
var(data$Number_of_transactions)

range(data$Product_calories)
range(data$Average_age)
range(data$Number_of_transactions)

# standard deviation and variance of three columns
lapply(data[, 1:3], sd)
lapply(data[, 1:3], var)

# Summarize the descriptive analysis of the data
summary(data)

# More descriptive analysis
install.packages("pastecs")
library(pastecs)
stat.desc(data)

# coefficient of variation
sd(data$Product_calories) / mean(data$Product_calories)
sd(data$Average_age) / mean(data$Average_age)
sd(data$Number_of_transactions) / mean(data$Number_of_transactions)

################################################################################

# Data Analysis

# Correlation Test

# For visualize data
install.packages("ggpubr")
library("ggpubr")

# check whether the highest calories have a relationship with the consumer age (average age will affect product calories that consumer intake or not)
ggscatter(data, x = "Average_age", y = "Product_calories",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Average age", ylab = "Product calories(kcal)")

# Correlation test information, using pearson method
res <- cor.test(data$Product_calories, data$Average_age, 
         method = "pearson")
res
res$p.value # p value
res$estimate # corr value


# check whether the highest transaction have a relationship with the product calories (number of transaction will affect the product calories that consumer intake or not)
ggscatter(data, x = "Number_of_transactions", y = "Product_calories",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Number of transactions", ylab = "Product calories(kcal)")

# Correlation test information, using pearson method
res <- cor.test(data$Product_calories, data$Number_of_transactions, 
         method = "pearson")
res
res$p.value # p value
res$estimate # corr value

# Each area

# Correlation in Borough Area

# Read data file
boroughAreaDec <- read.csv("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_borough_grocery.csv")
# View resulting data frame
boroughAreaDec %>% data.frame
# Keep the targeted columns: product calories, average age and number of transactions
boroughData = subset(boroughAreaDec, select = c(energy_density, avg_age, num_transactions))
boroughData

# Change the columns name
colnames(boroughData) <- c("Product_calories", "Average_age","Number_of_transactions")

# product calories and average age
ggscatter(boroughData, x = "Average_age", y = "Product_calories",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Average age", ylab = "Product calories(kcal)")

res <- cor.test(boroughData$Product_calories, boroughData$Average_age,
                method = "pearson")
res
res$p.value
res$estimate

# product calories and number of transactions
ggscatter(boroughData, x = "Number_of_transactions", y = "Product_calories",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Number of transactions", ylab = "Product calories(kcal)")

res <- cor.test(boroughData$Product_calories, boroughData$Number_of_transactions, 
                method = "pearson")
res
res$p.value
res$estimate


# Correlation in MSOA Area
msoaAreaDec <- read.csv("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_msoa_grocery.csv")
# View resulting data frame
msoaAreaDec %>% data.frame
# Keep the targeted columns: product calories, average age and number of transactions
msoaData = subset(msoaAreaDec, select = c(energy_density, avg_age, num_transactions))
msoaData
# Change the columns name
colnames(msoaData) <- c("Product_calories", "Average_age","Number_of_transactions")

# product calories and average age
ggscatter(msoaData, x = "Average_age", y = "Product_calories",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Average age", ylab = "Product calories(kcal)")

res <- cor.test(msoaData$Average_age, msoaData$Product_calories, 
                method = "pearson")
res
res$p.value
res$estimate

# product calories and number of transactions
ggscatter(msoaData, x = "Number_of_transactions", y = "Product_calories",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Number of transactions", ylab = "Product calories(kcal)")

res <- cor.test(msoaData$Product_calories, msoaData$Number_of_transactions, 
                method = "pearson")
res
res$p.value
res$estimate


# Correlation in Osward Area
oswardAreaDec <- read.csv("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_osward_grocery.csv")
# View resulting data frame
oswardAreaDec %>% data.frame 
# Keep the targeted columns: product calories, average age and number of transactions
oswardData = subset(oswardAreaDec, select = c(energy_density, avg_age, num_transactions))
oswardData
# Change the columns name
colnames(oswardData) <- c("Product_calories", "Average_age","Number_of_transactions")

# product calories and average age
ggscatter(oswardData, x = "Average_age", y = "Product_calories",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Average age", ylab = "Product calories(kcal)")

res <- cor.test(oswardData$Product_calories, oswardData$Average_age, 
                method = "pearson")
res
res$p.value
res$estimate

# product calories and number of transactions
ggscatter(oswardData, x = "Number_of_transactions", y = "Product_calories",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Number of transactions", ylab = "Product calories(kcal)")

res <- cor.test(oswardData$Product_calories, oswardData$Number_of_transactions, 
                method = "pearson")
res
res$p.value
res$estimate

##############################################################

# Hypothesis testing

# Combines of three areas: Borough, MSOA and Osward
# fit linear model: Product calories and Average age
linear_model <- lm(Product_calories ~ Average_age, data=data)
# view summary of linear model
summary(linear_model)
plot(linear_model)

# fit linear model: Product calories and Number of transaction
linear_model <- lm(Product_calories ~ Number_of_transactions, data=data)
# view summary of linear model
summary(linear_model)
plot(linear_model)


# Borough Area

# fit linear model: Product calories and Average age
linear_model <- lm(Product_calories ~ Average_age, data=boroughData)
# view summary of linear model
summary(linear_model)
plot(linear_model)


# fit linear model: Product calories and Number of transaction
linear_model <- lm(Product_calories ~ Number_of_transactions, data=boroughData)
# view summary of linear model
summary(linear_model)
plot(linear_model)


# MSOA Area

# fit linear model: Product calories and Average age
linear_model <- lm(Product_calories ~ Average_age, data=msoaData)
# view summary of linear model
summary(linear_model)
plot(linear_model)

# fit linear model: Product calories and Number of transaction
linear_model <- lm(Product_calories ~ Number_of_transactions, data=msoaData)
# view summary of linear model
summary(linear_model)
plot(linear_model)


# Osward Area
# fit linear model: Product calories and Average age
linear_model <- lm(Product_calories ~ Average_age, data=oswardData)
# view summary of linear model
summary(linear_model)
plot(linear_model)


# fit linear model: Product calories and Number of transaction
linear_model <- lm(Product_calories ~ Number_of_transactions, data=oswardData)
# view summary of linear model
summary(linear_model)
plot(linear_model)
