import("stats")
import("dplyr")


selectNumericColumnNames <- function(dataset) {
  numeric_column_names <- vapply(
    names(dataset),
    function(name) {
      if(is.numeric(dataset[[name]]))
        return(name)
      else
        return(NA_character_)
    },
    FUN.VALUE = character(1)
  )
  
  return(numeric_column_names %>% .[!is.na(.)])
}

prepareCleanNumVarNames <- function(dataset) {
  clean_names <- selectNumericColumnNames(dataset) %>% gsub(".", " ", ., fixed = TRUE)
  return(clean_names)
}

varSummary <- function(num_vector) {
  v_range <- range(num_vector, na.rm = TRUE)
  statistics <- c(
    mean(num_vector, na.rm = TRUE),
    sd(num_vector, na.rm = TRUE),
    v_range[1],
    v_range[2]
  )
  return(round(statistics, 2))
}


prepareVarSummary <- function(dataset) {
  numeric_dataset <- dataset[, selectNumericColumnNames(dataset)]
  summary_table <- apply(numeric_dataset, 2, varSummary) %>% t() %>% as.data.frame()
  names(summary_table) <- c("mean", "sd", "min", "max")
  summary_table$range <- paste0(summary_table$min, " : ", summary_table$max)
  return(summary_table[, c("mean", "sd", "range")])
}

