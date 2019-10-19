import("stats")

var_summary <- use("logic/utils_var_summary.R")


getCorrelatedVariables <- function(dataset, strength_index) {
  correlation_frame <- getCorrelationFrame(dataset)
  return(correlation_frame[strength_index, 1:2])
}

getCorrelationFrame <- function(dataset) {
  numeric_dataset <- dataset[, var_summary$selectNumericColumnNames(dataset)]
  corr_matrix <- cor(numeric_dataset)
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
