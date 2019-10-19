import("shiny")
import("DT")
import("plotly")
import("modules")
import("shinydashboard")

export("ui")
export("init_server")

CONSTS <- use("logic/constants.R")

ui <- function(id) {
  ns <- NS(id)

  fluidRow(

  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns

}
