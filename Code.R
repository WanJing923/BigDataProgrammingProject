# Comparison between Parallel and Sequential Processing 

# Using tidyverse to read data set
install.packages("tidyverse")
library(tidyverse)

df <-
  list.files(path = "C:/Users/lauwa/Documents/BigDataProgrammingProject/BigDataProgrammingProject/DATASET/", pattern = "*.csv") %>%
  map_df(~read_csv(.))
df

# Using microbenchmark to compare the two processing
install.packages("microbenchmark")
library(microbenchmark)

# Using parallel package
install.packages("parallel")
library(parallel)

f <- function(i) {
  lmer(Petal.Width ~ . - Species + (1 | Species), data = iris)}

system.time({
  library(lme4)
  save1 <- lapply(1:100, f)})


# Using sequential



# Start comparing
numCores <- detectCores()

results <- mclapply(1:100,
                    FUN=function(i) read.csv(paste0("./data/datafile-", i, ".csv")),
                    mc.cores = numCores)

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














