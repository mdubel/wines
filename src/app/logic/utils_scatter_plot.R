import("stats")

prepareFileSummary <- function(dataset) {
  return(
    data.frame("observations_count" = nrow(dataset),
               "full_observations_count" = nrow(na.omit(dataset)),
               "variables_count" = ncol(dataset))
  )
}
