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

# Compare the two functions
compare <- microbenchmark(tidyverse, 
                          lapply,
                          times = 2)

# Print compare
compare

# Plot output
library(ggplot2)

df <- data.frame(compare)
head(df)

p <- ggplot(data=df, aes(x=expr, y=time)) + geom_bar(stat="identity")

p










