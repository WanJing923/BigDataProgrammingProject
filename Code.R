#install.packages("parallel")

#library(parallel)
#library(MASS)

#data <- read.csv("C:/Users/lauwa/Downloads/DATASET/DATASET/Apr_borough_grocery.csv")


#starts <- rep(100, 40)
#fx <- function(nstart) kmeans(Boston, 4, nstart=nstart)
#numCores <- detectCores()
#numCores

#system.time(results <- lapply(starts, fx))








# Example 2 - Using tidyverse
install.packages("tidyverse")
library(tidyverse)
df <-
  list.files(path = "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/", pattern = "*.csv") %>%
  map_df(~read_csv(.))
df















