library(testthat)

test_results <- test_dir("tests/testthat", reporter = "summary", stop_on_failure = TRUE)
