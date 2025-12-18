aim_2_tab_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    # tags$div(class = "clickable-box", `data-tab-name` = "metric1_tab", valueBoxOutput(ns("metric1"))),
    # tags$div(class = "clickable-box", `data-tab-name` = "metric2_tab", valueBoxOutput(ns("metric2"))),
    # tags$div(class = "clickable-box", `data-tab-name` = "metric3_tab", valueBoxOutput(ns("metric3"))),
    tags$div(class = "clickable-box", `data-tab-name` = "metric4_tab", valueBoxOutput(ns("metric4"))),
    # tags$div(class = "clickable-box", `data-tab-name` = "metric5_tab", valueBoxOutput(ns("metric5"))),
    # tags$div(class = "clickable-box", `data-tab-name` = "metric6_tab", valueBoxOutput(ns("metric6"))),
    # tags$div(class = "clickable-box", `data-tab-name` = "metric7_tab", valueBoxOutput(ns("metric7"))),
    # tags$div(class = "clickable-box", `data-tab-name` = "metric8_tab", valueBoxOutput(ns("metric8"))),
    tags$div(class = "clickable-box", `data-tab-name` = "metric9_tab", valueBoxOutput(ns("metric9"))),
    tags$div(class = "clickable-box", `data-tab-name` = "metric10_tab", valueBoxOutput(ns("metric10"))),
    tags$div(class = "clickable-box", `data-tab-name` = "metric11_tab", valueBoxOutput(ns("metric11"))),
    tags$div(class = "clickable-box", `data-tab-name` = "metric12_tab", valueBoxOutput(ns("metric12"))),
    tags$div(class = "clickable-box", `data-tab-name` = "metric13_tab", valueBoxOutput(ns("metric13")))
    # tags$div(class = "clickable-box", `data-tab-name` = "metric14_tab", valueBoxOutput(ns("metric14")))
  )
}

aim_2_tab_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Reactive expression to access overall metric 2 data from global.R
      overall_metric2_data_reactive <- reactive({
        data$metric2_data %>%
          filter(CharacteristicType == "Overall")
      })
      
      output$metric1 <- renderValueBox({ valueBox(data$metric1, "Metric 1", icon = icon("list"), color = "orange") })
      
      output$metric2 <- renderValueBox({
        overall_data <- overall_metric2_data_reactive()
        current_percentage <- overall_data$Percentage[5]
        previous_percentage <- overall_data$Percentage[4]
        
        change <- round(current_percentage - previous_percentage, 1)
        
        if (change > 0) {
          arrow_icon <- icon("arrow-up")
          # color_vb <- "green" # Removed dynamic color
        } else if (change < 0) {
          arrow_icon <- icon("arrow-down")
          # color_vb <- "red" # Removed dynamic color
        } else {
          arrow_icon <- icon("minus")
          # color_vb <- "light-blue" # Removed dynamic color
        }
        
        valueBox(
          value = paste0(current_percentage, "%"),
          subtitle = HTML(paste0("Metric 2 (Overall) <br/>", change, "% vs Prev Qtr")),
          icon = arrow_icon,
          color = "light-blue" # Fixed color
        )
      })
      
      output$metric3 <- renderValueBox({ valueBox(data$metric3, "Metric 3", icon = icon("list"), color = "light-blue") })
      output$metric4 <- renderValueBox({ valueBox(data$metric4, "Metric 4", icon = icon("list"), color = "orange") })
      output$metric5 <- renderValueBox({ valueBox(data$metric5, "Metric 5", icon = icon("list"), color = "orange") })
      output$metric6 <- renderValueBox({ valueBox(data$metric6, "Metric 6", icon = icon("list"), color = "olive") })
      output$metric7 <- renderValueBox({ valueBox(data$metric7, "Metric 7", icon = icon("list"), color = "olive") })
      output$metric8 <- renderValueBox({ valueBox(data$metric8, "Metric 8", icon = icon("list"), color = "olive") })
      output$metric9 <- renderValueBox({ valueBox(data$metric9, "Metric 9", icon = icon("list"), color = "light-blue") })
      output$metric10 <- renderValueBox({ valueBox(data$metric10, "Metric 10", icon = icon("list"), color = "light-blue") })
      output$metric11 <- renderValueBox({ valueBox(data$metric11, "Metric 11", icon = icon("list"), color = "orange") })
      output$metric12 <- renderValueBox({ valueBox(data$metric12, "Metric 12", icon = icon("list"), color = "olive") })
      output$metric13 <- renderValueBox({ valueBox(data$metric13, "Metric 13", icon = icon("list"), color = "orange") })
      output$metric14 <- renderValueBox({ valueBox(data$metric14, "Metric 14", icon = icon("list"), color = "orange") })
    }
  )
}