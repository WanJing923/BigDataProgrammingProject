# Comparison between Parallel and Sequential Processing

# Using parallel package
install.packages("parallel")

# Using tidyverse to read data set
install.packages("tidyverse")

# Using microbenchmark to compare the two processing
install.packages("microbenchmark")

# Set working directory
setwd("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET")

library(parallel)
detectCores()

# Load the microbenchmark package
library(microbenchmark)

# Sequential processing
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
filenames <- list.files(path, pattern = "*.csv")
filenames
lapply_1 <- lapply(filenames,FUN = function(i){
  read.csv(i, header=TRUE, skip=4)
})

system.time(lapply(filenames,FUN = function(i){read.csv(i, header=TRUE, skip=4)}))

# Parallel processing
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
filenames <- list.files(path, pattern = "*.csv")
filenames

cl <- makeCluster(detectCores())

parLapply_1 <- parLapply(cl, filenames,fun = function(i){
  read.csv(i, header=TRUE, skip=4)
})

parLapply_1

stopCluster(cl)

# Compare the two functions
compare <- microbenchmark(parLapply_1, 
                          lapply_1,
                          times = 2)

# Print compare
compare

# Plot output
library(ggplot2)

df <- data.frame(compare)
head(df)

p <- ggplot(data=df, aes(x=expr, y=time)) + geom_bar(stat="identity")

p










