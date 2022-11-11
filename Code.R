# Comparison between Parallel and Sequential Processing

# Set working directory
setwd("C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET")

# Using parallel package
install.packages("parallel")
library(parallel)
detectCores()

# Using tidyverse to read data set
install.packages("tidyverse")
library(tidyverse)

path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"

df <- list.files(path, pattern = "*.csv") %>%
map_df(~read_csv(.))
df

# Using sequential
path <- "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/"

filenames <- list.files(path, pattern = "*.csv")
All <- lapply(filenames,function(i){
  read.csv(i, header=TRUE, skip=4)
})

system.time(save1 <- lapply(1:100, All))

# Using microbenchmark to compare the two processing
install.packages("microbenchmark")
library(microbenchmark)

f <- function() NULL
res <- microbenchmark(NULL, f(), times=1000L)
print(res)


mbm <- microbenchmark("lm" = { b <- lm(y ~ X + 0)$coef },
                      "pseudoinverse" = {
                        b <- solve(t(X) %*% X) %*% t(X) %*% y
                        },
                      "linear system" = {
                        b <- solve(t(X) %*% X, t(X) %*% y)
                        },
                      check = check_for_equal_coefs)

mbm
library(ggplot2)
autoplot(mbm)














