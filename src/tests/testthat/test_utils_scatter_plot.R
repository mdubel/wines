context("Scatter plot")
# move to the app folder - it is a WD when Shiny app runs
setwd("../../app")
scatter_plot <- use("logic/utils_scatter_plot.R")

context("getCorrelatedVariables")
test_that(
  "getCorrelatedVariables works for not integers", {
    expect_equal(scatter_plot$getCorrelatedVariables(iris, 2.9),
                 scatter_plot$getCorrelatedVariables(iris, 2))
  }
)

test_that(
  "getCorrelatedVariables works for too big index", {
    expect_warning(scatter_plot$getCorrelatedVariables(iris, 70))
  }
)

test_that(
  "getCorrelatedVariables works with default", {
    expect_equal(round(scatter_plot$getCorrelatedVariables(iris)[1,3], 2), 0.96)
  }
)

test_that(
  "getCorrelatedVariables returns 3 columns with given names", {
    expect_equal(names(scatter_plot$getCorrelatedVariables(iris)), c("row", "col", "corr"))
  }
)

context("getCorrelationForVars")
test_that(
  "getCorrelatedVariables returns error for non-numeric columns", {
    expect_error(scatter_plot$getCorrelationForVars(iris, "Petal.Length", "Species"))
  }
)

test_that(
  "getCorrelatedVariables returns 1 for same columns with warning", {
    expect_warning(scatter_plot$getCorrelationForVars(iris, "Petal.Length", "Petal.Length"))
  }
)
