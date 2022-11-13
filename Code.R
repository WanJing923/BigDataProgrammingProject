# Comparison between Parallel and Sequential Processing

# Using parallel package
install.packages("parallel")

# Using tidyverse to read data set
install.packages("tidyverse")

# Set working directory
setwd("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET")

library(parallel)
detectCores()

# Sequential processing
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
filenames <- list.files(path, pattern = "*.csv")
filenames
All <- lapply(filenames,FUN = function(i){
  read.csv(i, header=TRUE, skip=4)
})

All

sequential_time <- system.time(lapply(1:100, All))

# Parallel processing
library(tidyverse)
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
df <- list.files(path, pattern = "*.csv") %>%
map_df(~read_csv(.))
df

parallel_time <- system.time(map_df)

# Using microbenchmark to compare the two processing
install.packages("microbenchmark")

# Load the microbenchmark package
library(microbenchmark)

# Compare the two functions
compare <- microbenchmark(parallel_time, 
                          sequential_time, 
                          times = 10)

# Print compare
compare
library(ggplot2)
autoplot(compare)














