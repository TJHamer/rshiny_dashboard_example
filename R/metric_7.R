metric_7_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    valueBoxOutput(ns("metric")),
    box(title = "Details for Metric 7", width = 9, solidHeader = TRUE, verbatimTextOutput(ns("details")))
  )
}

metric_7_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$metric <- renderValueBox({
        valueBox(data$metric7, "Metric 7", icon = icon("list"), color = "purple")
      })
      
      output$details <- renderPrint({
        "Detailed information for metric 7."
      })
    }
  )
}
