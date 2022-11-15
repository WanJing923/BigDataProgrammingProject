# Comparison between Parallel and Sequential Processing

# Using parallel package
install.packages("parallel")

# Using tidyverse to read data set
install.packages("tidyverse")

# Using microbenchmark to compare the two processing
install.packages("microbenchmark")

# Using ggplot2 to visualize data
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















