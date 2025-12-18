metric_3_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    valueBoxOutput(ns("metric")),
    box(title = "Details for Metric 3", width = 9, solidHeader = TRUE, verbatimTextOutput(ns("details")))
  )
}

metric_3_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$metric <- renderValueBox({
        valueBox(data$metric3, "Metric 3", icon = icon("list"), color = "purple")
      })
      
      output$details <- renderPrint({
        "Detailed information for metric 3."
      })
    }
  )
}
