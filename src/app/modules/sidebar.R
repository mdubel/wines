import("shiny")

export("ui")
export("init_server")

CONSTS <- use("logic/constants.R")
#sidebar_fun <- use("logic/sidebar_fun.R")

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
