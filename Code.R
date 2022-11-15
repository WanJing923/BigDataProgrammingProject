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

library(parallel)
detectCores()

library(microbenchmark)

# Sequential
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
filenames <- list.files(path, pattern = "*.csv")
filenames
lapply_function <- lapply(filenames,FUN = function(i){
  read.csv(i, header=TRUE, skip=4)
})

# Parallel
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
filenames <- list.files(path, pattern = "*.csv")
filenames

cl <- makeCluster(detectCores())

parLapply_function <- parLapply(cl, filenames,fun = function(i){
  read.csv(i, header=TRUE, skip=4)
})

stopCluster(cl)

# Compare
compare <- microbenchmark(lapply_function,
                          parLapply_function,
                          times = 1)

# Print compare
compare

# Plot output
library(ggplot2)

df <- data.frame(compare)
head(df)

p <- ggplot(data=df, aes(x=expr, y=time)) + geom_bar(stat="identity")

p

# Descriptive Analysis

install.packages("dplyr")

library(dplyr)
library(readr)

# Import and merge three targeted CSV files
file1 <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_borough_grocery.csv"
file2 <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_msoa_grocery.csv"
file3 <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/Dec_osward_grocery.csv"

files <- list(file1, file2, file3)

df <- files %>% 
  lapply(read_csv) %>% 
  bind_rows 

# View resulting data frame
df %>% data.frame 

# View all rows or columns
df %>% print(n=Inf)
df %>% print(width=Inf)

# Keep the targeted columns: product calories, average age and number of transitions
data = df[c("energy_density","avg_age","num_transactions")]
data %>% print(n=Inf)

str(data)

# minimum, maximum and range of product calories
min(data$energy_density)
max(data$energy_density)
range(data$energy_density)

# minimum, maximum and range of average age
min(data$avg_age)
max(data$avg_age)
range(data$avg_age)


# minimum, maximum and range of number of transitions
min(data$num_transactions)
max(data$num_transactions)
range(data$num_transactions)

# mean of product calories, average age and number of transitions
mean(data$energy_density)
mean(data$avg_age)
mean(data$num_transactions)

# median of product calories, average age and number of transitions
median(data$energy_density)
median(data$avg_age)
median(data$num_transactions)

# first and third quartile of product calories, average age and number of transitions
quantile(data$energy_density, 0.25)
quantile(data$energy_density, 0.75)

quantile(data$avg_age, 0.25)
quantile(data$avg_age, 0.75)

quantile(data$num_transactions, 0.25)
quantile(data$num_transactions, 0.75)

# interquartile range of product calories, average age and number of transitions
IQR(data$energy_density)
IQR(data$avg_age)
IQR(data$num_transactions)

# standard deviation and variance of product calories, average age and number of transactions
sd(data$energy_density)
sd(data$avg_age)
sd(data$num_transactions)

var(data$energy_density)
var(data$avg_age)
var(data$num_transactions)

# standard deviation and variance of three columns
lapply(data[, 1:3], sd)
lapply(data[, 1:3], var)

summary(data)

# More descriptive analysis
install.packages("pastecs")
library(pastecs)
stat.desc(data)

# coefficient of variation
sd(data$energy_density) / mean(data$energy_density)
sd(data$avg_age) / mean(data$avg_age)
sd(data$num_transactions) / mean(data$num_transactions)

# Data Analysis

# Correlation Test
install.packages("ggpubr")
library("ggpubr")

# check whether the highest calories have a relationship with the consumer age
ggscatter(data, x = "energy_density", y = "avg_age", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Product calories(kcal)", ylab = "Average age")

res <- cor.test(data$energy_density, data$avg_age, 
         method = "pearson")

res$p.value

res$estimate

# check whether the highest transaction have a relationship with the product calories
ggscatter(data, x = "energy_density", y = "num_transactions", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Product calories(kcal)", ylab = "Number of transactions")

res <- cor.test(data$energy_density, data$num_transactions, 
         method = "pearson")

res$p.value

res$estimate



res2 <- cor.test(data$energy_density, data$avg_age, method="kendall")
res2

res2 <-cor.test(data$energy_density, data$avg_age, method = "spearman")
res2









# Hypothesis Testing




