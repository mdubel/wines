function(input, output, session) {
  sidebar$init_server("sidebar")
  file_summary$init_server("file_summary")
  var_summary$init_server("var_summary")
  group_plot$init_server("group_plot")
  scatter_plot$init_server("scatter_plot")
}
