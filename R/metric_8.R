metric_8_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    valueBoxOutput(ns("metric")),
    box(title = "Details for Metric 8", width = 9, solidHeader = TRUE, verbatimTextOutput(ns("details")))
  )
}

metric_8_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$metric <- renderValueBox({
        valueBox(data$metric8, "Metric 8", icon = icon("list"), color = "purple")
      })
      
      output$details <- renderPrint({
        "Detailed information for metric 8."
      })
    }
  )
}
