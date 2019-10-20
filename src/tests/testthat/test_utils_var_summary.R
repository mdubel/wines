context("Var summary")
# move to the app folder - it is a WD when Shiny app runs
setwd("../../app")
var_summary <- use("logic/utils_var_summary.R")

context("selectNumericColumnNames")
test_that(
  "selectNumericColumnNames works", {
    expect_equal(length(var_summary$selectNumericColumnNames(iris)),
                 4)
  }
)

context("selectNonNumericColumnNames")
test_that(
  "selectNonNumericColumnNames works", {
    expect_equal(length(var_summary$selectNonNumericColumnNames(iris)),
                 1)
  }
)

context("prepareCleanNumVarNames")
test_that(
  "prepareCleanNumVarNames works", {
    expect_equivalent(var_summary$prepareCleanNumVarNames(iris)[1],
                      "Sepal Length")
  }
)

context("varSummary")
test_that(
  "varSummary works", {
    expect_equal(length(var_summary$varSummary(iris$Sepal.Length)),
                 4)
  }
)