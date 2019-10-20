import("stats")
import("utils")
var_summary <- use("logic/utils_var_summary.R")

#' Function for extracting the {strength_index} most correlated variables
#'
#' @param dataset data.frame; dataset with some numeric variables
#' @param strength_index integer; which highest correlated variables to return
#'
#' @return data.frame; single row with three columns:
#' character {row}, {col} with variable names and numeric {corr} with correlation value 
#'
#' @examples getCorrelatedVariables(iris, 3)
getCorrelatedVariables <- function(dataset, strength_index = 1) {
  stopifnot(is.numeric(strength_index))
  correlation_frame <- getCorrelationFrame(dataset)
  if(strength_index > nrow(correlation_frame)) {
    warning("There are not enough variables in dataset to return such high index - lowest correlation returned instead")
    return(tail(correlation_frame, 1))
  }
  return(correlation_frame[strength_index, ])
}


#' Returns correlation for given variables in dataset
#'
#' @param dataset data.frame; contains some numerical variables
#' @param var1 character; one of the numerical columns in {dataset}
#' @param var2 character; one of the numerical columns in {dataset}
#'
#' @return numeric; correlation value between given columns
#'
#' @examples getCorrelationForVars(iris, "Petal.Width", "Petal.Length")
getCorrelationForVars <- function(dataset, var1, var2) {
  stopifnot(is.character(var1), is.character(var2), var1 %in% names(dataset), var2 %in% names(dataset))
  stopifnot(is.numeric(dataset[[var1]]), is.numeric(dataset[[var2]]))
  if(var1 == var2) {
    warning("Same columns provided, the correlation is of course equal to 1")
    return(1)
  }
  
  correlation_frame <- getCorrelationFrame(dataset)
  if(nrow(subset(correlation_frame, row == var1 & col == var2)) > 0)
    corr_value <- subset(correlation_frame, row == var1 & col == var2)[,3]
  else
    corr_value <- subset(correlation_frame, row == var2 & col == var1)[,3]
  
  return(round(corr_value, 2))
}

#' Calculates correlation matrix for given dataset and transforms it to ordered table
#'
#' @param dataset data.frame; contains some numerical variables
#'
#' @return
#'
#' @examples getCorrelationFrame(iris)
getCorrelationFrame <- function(dataset) {
  numeric_columns <- var_summary$selectNumericColumnNames(dataset)
  stopifnot(length(numeric_columns) > 0)
  
  numeric_dataset <- dataset[, numeric_columns]
  corr_matrix <- cor(numeric_dataset, use = "pairwise.complete.obs")
  upper_tri <- upper.tri(corr_matrix)
  correlation_frame <- data.frame(
    row = rownames(corr_matrix)[row(corr_matrix)[upper_tri]], 
    col = colnames(corr_matrix)[col(corr_matrix)[upper_tri]], 
    corr = corr_matrix[upper_tri]
  )
  
  return(
    correlation_frame[order(correlation_frame$corr, decreasing = TRUE), ]
  )
}
