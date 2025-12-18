metric_5_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    valueBoxOutput(ns("metric")),
    box(title = "Details for Metric 5", width = 9, solidHeader = TRUE, verbatimTextOutput(ns("details")))
  )
}

metric_5_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$metric <- renderValueBox({
        valueBox(data$metric5, "Metric 5", icon = icon("list"), color = "purple")
      })
      
      output$details <- renderPrint({
        "Detailed information for metric 5."
      })
    }
  )
}
