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
lapply <- lapply(filenames,FUN = function(i){
  read.csv(i, header=TRUE, skip=4)
})

system.time(lapply(filenames,FUN = function(i){read.csv(i, header=TRUE, skip=4)}))

# Parallel processing
library(tidyverse)
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"
tidyverse <- list.files(path, pattern = "*.csv") %>%
map_df(~read_csv(.))

tidyverse

system.time(list.files(path, pattern = "*.csv") %>%
              map_df(~read_csv(.)))


# Using microbenchmark to compare the two processing
install.packages("microbenchmark")

# Load the microbenchmark package
library(microbenchmark)

# Compare the two functions
compare <- microbenchmark(tidyverse, 
                          lapply, 
                          times = 6)

# Print compare
compare
library(ggplot2)
autoplot(compare)














