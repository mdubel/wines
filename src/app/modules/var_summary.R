import("shiny")
import("DT")
import("plotly")
import("modules")
import("shinydashboard")

export("ui")
export("init_server")

CONSTS <- use("logic/constants.R")
var_summary <- use("logic/utils_var_summary.R")

ui <- function(id) {
  ns <- NS(id)

  DTOutput(ns("varsummary"))
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns

  output$varsummary <- DT::renderDT(
    DT::datatable(
      var_summary$prepareVarSummary(CONSTS$DATA),
      rownames = var_summary$prepareCleanNumVarNames(CONSTS$DATA),
      colnames = c("Mean", "Std. dev.", "Range"),
      style = "bootstrap",
      extensions = 'Buttons',
      selection = 'none',
      options = list(
        dom = 'tB',
        buttons = c('copy', 'csv', 'excel', 'pdf'),
        ordering = TRUE
      )
    )
  )
}
