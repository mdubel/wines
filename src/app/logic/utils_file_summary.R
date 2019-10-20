import("stats")

#' Creates content for file summary table
#'
#' @param dataset data.frame; loaded csv file of interest
#'
#' @return data.frame; single row and three columns:
#'  observations_count, full_observations_count, variables_count
#'
#' @examples prepareFileSummary(iris)
prepareFileSummary <- function(dataset) {
  stopifnot(nrow(dataset) > 0, ncol(dataset) > 0)
  return(
    data.frame("observations_count" = nrow(dataset),
               "full_observations_count" = nrow(na.omit(dataset)),
               "variables_count" = ncol(dataset))
  )
}
