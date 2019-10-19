library(shiny)
library(modules)

sidebar <- use("modules/sidebar.R")

file_summary <- use("modules/file_summary.R")
var_summary <- use("modules/var_summary.R")
group_plot <- use("modules/group_plot.R")
scatter_plot <- use("modules/scatter_plot.R")