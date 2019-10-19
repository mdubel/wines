import("shiny")
import("DT")
import("plotly")
import("modules")
import("shinydashboard")
import("ggplot2")

export("ui")
export("init_server")

CONSTS <- use("logic/constants.R")
var_summary <- use("logic/utils_var_summary.R")
scatter_plot <- use("logic/utils_scatter_plot.R")

ui <- function(id) {
  ns <- NS(id)

  fluidRow(
    fluidRow(
      column(width = 6,
             uiOutput(ns("var1selection"), style = "font-size: 10px;")),
      column(width = 6,
             uiOutput(ns("var2selection"), style = "font-size: 10px;"))
    ),
    fluidRow(
      column(width = 12,
             plotOutput(ns("scatterplot"), height = '150px'))
    )
  )
}

init_server <- function(id, correlation) {
  callModule(server, id, correlation)
}

server <- function(input, output, session,
                   correlation) {
  ns <- session$ns

  clean_choices <- var_summary$selectNumericColumnNames(CONSTS$DATA)
  names(clean_choices) <- var_summary$prepareCleanNumVarNames(CONSTS$DATA)
  
  correlation_variables <- scatter_plot$getCorrelatedVariables(CONSTS$DATA, correlation)
  
  output$var1selection <- renderUI({
    selectInput(
      inputId = ns("var1selection"),
      label = "",
      choices = clean_choices,
      selected = correlation_variables[1,1]
    )
  })
  
  output$var2selection <- renderUI({
    selectInput(
      inputId = ns("var2selection"),
      label = "",
      choices = clean_choices,
      selected = correlation_variables[1,2]
    )
  })
  
  output$scatterplot <- renderPlot({
    req(input$var1selection)
    req(input$var2selection)
    
    theme_set(
      theme_classic() + 
        theme(legend.position = "bottom")
    )
    
    # NOTE: x is var2, y is var1 as it is more intuitive on plot
    ggplot(CONSTS$DATA,
           aes(x = CONSTS$DATA[[input$var2selection]],
               y = CONSTS$DATA[[input$var1selection]])) +
      geom_point(alpha = 0.2, colour = '#3c8dbc') +
      labs(x = input$var2selection,
           y = input$var1selection)
    
  })
}
