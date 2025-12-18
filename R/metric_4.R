metric_4_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    valueBoxOutput(ns("metric")),
    box(title = "Details for Metric 4", width = 9, solidHeader = TRUE, verbatimTextOutput(ns("details")))
  )
}

metric_4_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$metric <- renderValueBox({
        valueBox(data$metric4, "Metric 4", icon = icon("list"), color = "purple")
      })
      
      output$details <- renderPrint({
        "Detailed information for metric 4."
      })
    }
  )
}
