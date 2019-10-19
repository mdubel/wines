import("stats")

var_summary <- use("logic/utils_var_summary.R")


getCorrelatedVariables <- function(dataset, strength_index) {
  correlation_frame <- getCorrelationFrame(dataset)
  return(correlation_frame[strength_index, ])
}

getCorrelationForVars <- function(dataset, var1, var2) {
  correlation_frame <- getCorrelationFrame(dataset)
  
  if(nrow(subset(correlation_frame, row == var1 & col == var2)) > 0)
    corr_value <- subset(correlation_frame, row == var1 & col == var2)[,3]
  else
    corr_value <- subset(correlation_frame, row == var2 & col == var1)[,3]
  
  return(round(corr_value, 2))
}

getCorrelationFrame <- function(dataset) {
  numeric_dataset <- dataset[, var_summary$selectNumericColumnNames(dataset)]
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
