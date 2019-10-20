import("stats")
import("utils")
import("dplyr")


#' From given dataset returns vector of numeric column names
#'
#' @param dataset data.frame; dataset of interest, should contain some numeric variables
#'
#' @return character; names of numeric variables
#'
#' @examples selectNumericColumnNames(iris)
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
  # remove the spare values
  numeric_column_names <- numeric_column_names %>% .[!is.na(.)]
  
  if(length(numeric_column_names) == 0)
    simpleError("No numeric columns found")
  
  return(numeric_column_names)
}

#' Returns column names that are non-numeric
#'
#' @param dataset data.frame; dataset of interest, should contain some numeric variables
#'
#' @return character; names of non-numeric variables
#'
#' @examples selectNonNumericColumnNames(iris)
selectNonNumericColumnNames <- function(dataset) {
  # for context of the demo app this is enough: in general there maybe more columns or non-character ones
  setdiff(names(dataset), selectNumericColumnNames(dataset)) %>% head(., 2) # no more than two please
}

#' Transforms technical column names to more human readible
#'
#' @param dataset data.frame; dataset of interest, should contain some numeric variables
#'
#' @return character; vector of column names with spaces
#'
#' @examples prepareCleanNumVarNames(iris)
prepareCleanNumVarNames <- function(dataset) {
  clean_names <- selectNumericColumnNames(dataset) %>% gsub(".", " ", ., fixed = TRUE)
  return(clean_names)
}

#' For a given numeric vector returns basic statistics: mean, sd, min, max
#'
#' @param num_vector numeric; numeric vector e.g. single data.frame column
#'
#' @return numeric vector of mean, sd, min and max
#'
#' @examples varSummary(iris$Petal.Width)
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


#' Returns table ready for displaying on dashboard
#'
#' @param dataset data.frame; dataset of interest, should contain some numeric variables
#'
#' @return data.frame of columns: (numeric) mean, (numeric) sd, (character) range
#'
#' @examples prepareVarSummary(iris)
prepareVarSummary <- function(dataset) {
  numeric_dataset <- dataset[, selectNumericColumnNames(dataset)]
  summary_table <- apply(numeric_dataset, 2, varSummary) %>% t() %>% as.data.frame()
  names(summary_table) <- c("mean", "sd", "min", "max")
  summary_table$range <- paste0(summary_table$min, " : ", summary_table$max)
  return(summary_table[, c("mean", "sd", "range")])
}

