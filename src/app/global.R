library(modules)
library(shiny)
library(dplyr)
library(DT)
library(plotly)
library(shinydashboard)
library(ggplot2)
library(shinycustomloader)

file_summary <- use("modules/file_summary.R")
var_summary <- use("modules/var_summary.R")
group_plot <- use("modules/group_plot.R")
scatter_plot <- use("modules/scatter_plot.R")