function(input, output, session) {
  
  ###
  # The app has following structure:
  # - dataset of interest (csv ; separated) is loaded from /data folder
  # - one file in /data is expected; the name of the file does not matter
  # - dashboard is build with four blocks defined in the /modules folder
  # - modules are initialised in global.R file
  # - the external functions for each module are defined in /logic folder
  # - /www contains additional css script for visual improvements/changes
  ###
  
  file_summary$init_server("file_summary")
  var_summary$init_server("var_summary")
  group_plot$init_server("group_plot")
  scatter_plot$init_server("scatter_plot1", 1)
  scatter_plot$init_server("scatter_plot2", 2)
  scatter_plot$init_server("scatter_plot3", 3)
}
