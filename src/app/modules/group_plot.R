import("shiny")
import("plotly")
import("modules")
import("shinydashboard")
import("ggplot2")
import("shinycustomloader")

export("ui")
export("init_server")

CONSTS <- use("logic/constants.R")
var_summary <- use("logic/utils_var_summary.R")

ui <- function(id) {
  ns <- NS(id)

  fluidRow(
    fluidRow(
      column(width = 3,
             offset = 1,
             uiOutput(ns("varselection"))),
      column(width = 2,
             tags$h4("group by", style = "padding-top: 20px; text-align: center;")),
      column(width = 3,
             uiOutput(ns("groupselection"))),
      column(width = 3,
             uiOutput(ns("histogramtype")))
    ),
    fluidRow(
      column(width = 6,
             withLoader(plotlyOutput(ns("boxplot")), type = "html", loader = "loader4")
      ),
      column(width = 6,
             withLoader(plotlyOutput(ns("histogramdensityplot")), type = "html", loader = "loader4")
      )
    )
  )
}

init_server <- function(id) {
  callModule(server, id)
}

server <- function(input, output, session) {
  ns <- session$ns

  output$varselection <- renderUI({
    clean_choices <- var_summary$selectNumericColumnNames(CONSTS$DATA)
    names(clean_choices) <- var_summary$prepareCleanNumVarNames(CONSTS$DATA)
    selectInput(
      inputId = ns("varselection"),
      label = "",
      choices = clean_choices,
      selectize = TRUE
    )
  })
  
  output$groupselection <- renderUI({
    checkboxGroupInput(
      inputId = ns("groupselection"),
      label = "",
      choices = var_summary$selectNonNumericColumnNames(CONSTS$DATA),
      selected = var_summary$selectNonNumericColumnNames(CONSTS$DATA),
      inline = TRUE
    )
  })
  
  output$boxplot <- renderPlotly({
    req(input$varselection)
    validate(
      need(length(input$groupselection) > 0,
           "Please select at least one group variable")
    )
    
    plot_ly(CONSTS$DATA,
            x = CONSTS$DATA[[input$groupselection[1]]],
            y = CONSTS$DATA[[input$varselection]],
            color = CONSTS$DATA[[input$groupselection[2]]],
            type = "box") %>%
      layout(boxmode = "group",
             legend = list(orientation = 'h')) %>%
      config(displayModeBar = FALSE)
  })
  
  output$histogramtype <- renderUI({
    radioButtons(
      inputId = ns("histogramtype"),
      label = "",
      choices = c("histogram", "density"),
      selected = "histogram",
      inline = TRUE
    )
  })
  
  output$histogramdensityplot <- renderPlotly({
    req(input$varselection)
    validate(
      need(length(input$groupselection) > 0,
           "Please select at least one group variable")
    )

    theme_set(
      theme_classic() + 
        theme(legend.position = "bottom")
    )
    
    grouped_data <- CONSTS$DATA
    grouped_data$group <- paste(CONSTS$DATA[[input$groupselection[1]]], CONSTS$DATA[[input$groupselection[2]]])
    group_count <- length(unique(grouped_data$group))
    
    if(input$histogramtype == "histogram") {
      g <- ggplot(grouped_data, aes(x = grouped_data[[input$varselection]])) +
        geom_histogram(aes(color = group, fill = group), 
                       position = "identity", bins = 30, alpha = 0.2)
    } else if(input$histogramtype == "density") {
      g <- ggplot(grouped_data, aes(x = grouped_data[[input$varselection]])) +
        geom_density(alpha = 0.2, aes(color = group, fill = group))
    }
    
    ggplotly(g, tooltip = c("y", "color")) %>% 
    layout(legend = list(x = 0.9, y = 0.9), xaxis = list(title = ""), yaxis = list(title = "")) %>%
      config(displayModeBar = FALSE)
  })
  
}
