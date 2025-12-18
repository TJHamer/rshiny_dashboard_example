metric_1_ui <- function(id) {
  ns <- NS(id)
  
  fluidPage(
    fluidRow(
      valueBoxOutput(ns("metric")),
      box(title = "Details for Metric 1", width = 9, solidHeader = TRUE, verbatimTextOutput(ns("details")))
    ),
    fluidRow( # New fluidRow 1
      box(
        title = "Additional Information for Metric 1 - Section A",
        width = 6,
        solidHeader = TRUE,
        HTML("<p>This is some additional information for Metric 1. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>")
      ),
      box(
        title = "Additional Information for Metric 1 - Section B",
        width = 6,
        solidHeader = TRUE,
        HTML("<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>")
      )
    ),
    fluidRow( # New fluidRow 2
      box(
        title = "Further Details for Metric 1",
        width = 12,
        solidHeader = TRUE,
        HTML("<p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.</p>")
      )
    )
  )
}

metric_1_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$metric <- renderValueBox({ valueBox(data$metric1, "Metric 1", icon = icon("list"), color = "purple") })
      
      output$details <- renderPrint({
        "Detailed information for metric 1."
      })
    }
  )
}