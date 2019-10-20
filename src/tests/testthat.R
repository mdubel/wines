library(testthat)
library(modules)

test_results <- test_dir("src/tests/testthat", reporter = "summary", stop_on_failure = TRUE)
