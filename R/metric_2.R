library(dplyr) # Added to ensure dplyr functions are available
library(scales) # Added for hue_pal

metric_2_ui <- function(id) {
  ns <- NS(id)
  
  fluidPage(
    fluidRow( # New fluidRow for the Select Characteristic Type box
      box(
        title = "Select Characteristic Type",
        width = 12,
        solidHeader = TRUE,
        selectInput(
          ns("characteristic_type_selection"),
          label = "View by:",
          choices = c(
            "Overall",
            "Gender",
            "Region",
            "Height",
            "Width",
            "Group"
          ),
          selected = "Overall"
        ),
        uiOutput(ns("show_hide_selection_ui")), # Dynamic UI for show/hide selection
        uiOutput(ns("highlight_selection_ui")) # Dynamic UI for highlight selection
      )
    ), # Added comma here
    
    fluidRow( # New fluidRow for the value boxes
      valueBoxOutput(ns("metric")),
      valueBoxOutput(ns("metric2b_box"))
    ), # Added comma here
    
    fluidRow( # Existing fluidRow for the tabsetPanel
      tabsetPanel(
        id = ns("metric2_plots_tabset"), # Give the tabset an ID
        tabPanel(
          "Percentage Trend",
          fluidRow(
            box(
              title = "Metric 2: Percentage Performance Narrative",
              width = 12,
              solidHeader = TRUE,
              HTML("
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
              <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
              <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
            ")
            ),
            box(
              title = "Metric 2 Trend (Percentage)",
              width = 12,
              solidHeader = TRUE,
              plotOutput(ns("metric2_plot_percentage")) # Plot for metric 2 percentage
            )
          )
        ),
        tabPanel(
          "Days per Week Trend",
          fluidRow(
            box(
              title = "Metric 2b: Days per Week Performance Narrative",
              width = 12,
              solidHeader = TRUE,
              HTML("
              <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
              <p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
              <p>Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.</p>
            ")
            ),
            box(
              title = "Metric 2b Trend (Days per Week)",
              width = 12,
              solidHeader = TRUE,
              plotOutput(ns("metric2_plot_daysperweek")) # Plot for metric 2b days per week
            )
          )
        )
      )
    ), # Added comma here
    
    fluidRow( # Existing fluidRow for the details box
      box(title = "Details for Metric 2", width = 12, solidHeader = TRUE, verbatimTextOutput(ns("details")))
    )
  )
}

metric_2_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Access all dummy data from global.R reactively
      all_metric2_data_long_reactive <- reactive({
        data$metric2_data
      })
      
      # Base reactive expression to get data for the selected characteristic type
      base_filtered_plot_data <- reactive({
        req(input$characteristic_type_selection)
        
        current_data <- all_metric2_data_long_reactive() %>%
          filter(CharacteristicType == input$characteristic_type_selection)
        
        if (input$characteristic_type_selection != "Overall") {
          overall_data <- all_metric2_data_long_reactive() %>%
            filter(CharacteristicType == "Overall")
          current_data <- rbind(current_data, overall_data)
        }
        
        current_data
      })
      
      # Render the UI for the show/hide selection
      output$show_hide_selection_ui <- renderUI({
        ns <- session$ns
        choices <- unique(base_filtered_plot_data()$CharacteristicValue)
        
        pickerInput(
          ns("show_hide_selection"),
          label = "Show/Hide:",
          choices = choices,
          selected = choices,
          options = list(`actions-box` = TRUE),
          multiple = TRUE
        )
      })
      
      # Reactive expression to get data for the plot based on show/hide selection
      filtered_plot_data <- reactive({
        req(input$show_hide_selection)
        base_filtered_plot_data() %>%
          filter(CharacteristicValue %in% input$show_hide_selection)
      })
      
      # Render the UI for the highlight selection
      output$highlight_selection_ui <- renderUI({
        ns <- session$ns
        choices <- unique(filtered_plot_data()$CharacteristicValue)
        
        pickerInput(
          ns("highlight_selection"),
          label = "Highlight:",
          choices = choices,
          selected = choices,
          options = list(`actions-box` = TRUE),
          multiple = TRUE
        )
      })
      
      # Reactive for value boxes (always show overall or first available)
      value_box_data <- reactive({
        if ("Overall" %in% filtered_plot_data()$CharacteristicValue) {
          filtered_plot_data() %>% filter(CharacteristicValue == "Overall")
        } else {
          filtered_plot_data() %>% filter(CharacteristicValue == unique(CharacteristicValue)[1])
        }
      })
      
      output$metric <- renderValueBox({
        data_for_vb <- value_box_data()
        current_percentage <- data_for_vb$Percentage[5]
        previous_percentage <- data_for_vb$Percentage[4]
        
        change <- round(current_percentage - previous_percentage, 1)
        
        if (change > 0) {
          arrow_icon <- icon("arrow-up")
          color_vb <- "green"
        } else if (change < 0) {
          arrow_icon <- icon("arrow-down")
          color_vb <- "red"
        } else {
          arrow_icon <- icon("minus")
          color_vb <- "light-blue"
        }
        
        valueBox(
          value = paste0(current_percentage, "%"),
          subtitle = HTML(paste0("Metric 2 (Latest) <br/>", change, "% vs Prev Qtr")),
          icon = arrow_icon,
          color = color_vb
        )
      })
      
      output$metric2b_box <- renderValueBox({
        data_for_vb <- value_box_data()
        current_daysperweek <- data_for_vb$DaysPerWeek[5]
        previous_daysperweek <- data_for_vb$DaysPerWeek[4]
        
        change <- round(current_daysperweek - previous_daysperweek, 1)
        
        if (change > 0) {
          arrow_icon <- icon("arrow-up")
          color_vb <- "green"
        } else if (change < 0) {
          arrow_icon <- icon("arrow-down")
          color_vb <- "red"
        } else {
          arrow_icon <- icon("minus")
          color_vb <- "light-blue"
        }
        
        valueBox(
          value = paste0(current_daysperweek, " days"),
          subtitle = HTML(paste0("Metric 2b (Latest) <br/>", change, " days vs Prev Qtr")),
          icon = arrow_icon,
          color = color_vb
        )
      })
      
      output$metric2_plot_percentage <- renderPlot({
        plot_data <- filtered_plot_data()
        
        highlighted_data <- plot_data %>% filter(CharacteristicValue %in% input$highlight_selection)
        unhighlighted_data <- plot_data %>% filter(!CharacteristicValue %in% input$highlight_selection)
        
        # Generate a color palette
        unique_characteristics <- unique(plot_data$CharacteristicValue)
        color_palette <- hue_pal()(length(unique_characteristics))
        names(color_palette) <- unique_characteristics
        
        p <- ggplot() +
          geom_line(data = unhighlighted_data, aes(x = Quarter, y = Percentage, group = CharacteristicValue), color = "grey", alpha = 0.5, size = 1.5) +
          geom_point(data = unhighlighted_data, aes(x = Quarter, y = Percentage, group = CharacteristicValue), color = "grey", alpha = 0.5, size = 3) +
          geom_line(data = highlighted_data, aes(x = Quarter, y = Percentage, color = CharacteristicValue, group = CharacteristicValue), size = 1.5) +
          geom_point(data = highlighted_data, aes(x = Quarter, y = Percentage, color = CharacteristicValue, group = CharacteristicValue), size = 3) +
          scale_color_manual(values = color_palette) +
          ylim(0, 100) +
          labs(title = paste("Metric 2: Quarterly Performance by", input$characteristic_type_selection),
               y = "Percentage (%)",
               x = "Quarter",
               color = "Characteristic") +
          theme_classic() +
          theme(legend.position = "bottom")
        
        print(p)
      })
      
      output$metric2_plot_daysperweek <- renderPlot({
        plot_data <- filtered_plot_data()
        
        highlighted_data <- plot_data %>% filter(CharacteristicValue %in% input$highlight_selection)
        unhighlighted_data <- plot_data %>% filter(!CharacteristicValue %in% input$highlight_selection)
        
        # Generate a color palette
        unique_characteristics <- unique(plot_data$CharacteristicValue)
        color_palette <- hue_pal()(length(unique_characteristics))
        names(color_palette) <- unique_characteristics
        
        p <- ggplot() +
          geom_line(data = unhighlighted_data, aes(x = Quarter, y = DaysPerWeek, group = CharacteristicValue), color = "grey", alpha = 0.5, size = 1.5) +
          geom_point(data = unhighlighted_data, aes(x = Quarter, y = DaysPerWeek, group = CharacteristicValue), color = "grey", alpha = 0.5, size = 3) +
          geom_line(data = highlighted_data, aes(x = Quarter, y = DaysPerWeek, color = CharacteristicValue, group = CharacteristicValue), size = 1.5) +
          geom_point(data = highlighted_data, aes(x = Quarter, y = DaysPerWeek, color = CharacteristicValue, group = CharacteristicValue), size = 3) +
          scale_color_manual(values = color_palette) +
          ylim(0, 5) +
          labs(title = paste("Metric 2b: Quarterly Days per Week by", input$characteristic_type_selection),
               y = "Days per Week",
               x = "Quarter",
               color = "Characteristic") +
          theme_classic() +
          theme(legend.position = "bottom")
        
        print(p)
      })
      
      output$details <- renderPrint({
        paste("Detailed information for metric 2, including its quarterly trend and days per week for the selected characteristic type:", input$characteristic_type_selection)
      })
    }
  )
}