import("shiny")
import("DT")
import("plotly")
import("modules")
import("shinydashboard")

export("ui")
export("init_server")

CONSTS <- use("logic/constants.R")
file_summary <- use("logic/utils_file_summary.R")

ui <- function(id) {
  ns <- NS(id)

  DTOutput(ns("filesummary"))
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns
  
  output$filesummary <- DT::renderDT(
    DT::datatable(
      file_summary$prepareFileSummary(CONSTS$DATA),
      rownames = FALSE,
      colnames = c("No. of observations", "No. of complete observations", "No. of columns"),
      style = "bootstrap",
      selection = 'none',
      options = list(
        dom = 't',
        ordering = FALSE
      )
    )
  )
}
