library(shiny)
library(shinyWidgets)
library(dplyr)
library(DT)
library(plotly)
library(shinydashboard)
library(ggplot2)
library(grDevices)

dashboardPage(title = "Demo",
  dashboardHeader(
    title = 'Demo',#tags$img(src="logo.svg"),
    titleWidth = 150
  ),
  dashboardSidebar(
    width = 0,
    sidebar$ui("sidebar")
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/general.css")
    ),
    fluidRow(
      column(
        width = 4,
        file_summary$ui("file_summary"),
        var_summary$ui("var_summary")
      ),
      column(
        width = 8,
        group_plot$ui("group_plot"),
        scatter_plot$ui("scatter_plot")
      )
    )
  )
)
