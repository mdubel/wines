context("File summary")
# move to the app folder - it is a WD when Shiny app runs
setwd("../../app")
file_summary <- use("logic/utils_file_summary.R")

context("prepareFileSummary")
test_that(
  "prepareFileSummary returns 3 columns", {
    expect_equal(names(file_summary$prepareFileSummary(iris)),
                 c("observations_count", "full_observations_count", "variables_count"))
  }
)