# Load global settings and modules
source("global.R")

# Define UI
ui <- dashboardPage(
  title = "Metrics Dashboard", # Set title for browser tab
  header <- dashboardHeader(
    title = "Metrics Dashboard",
    
    # Aim 1
    tags$li(
      class = "dropdown",
      tags$a(
        href = "#",
        onclick = "Shiny.setInputValue('clicked_tab', 'aim_1', {priority: 'event'});",
        icon("bullseye"),
        " Aim 1",
        style = "cursor: pointer;"
      )
    ),
    
    # Aim 2
    tags$li(
      class = "dropdown",
      tags$a(
        href = "#",
        onclick = "Shiny.setInputValue('clicked_tab', 'aim_2', {priority: 'event'});",
        icon("bullseye"),
        " Aim 2",
        style = "cursor: pointer;"
      )
    )
  ),
  sidebar = dashboardSidebar(
    collapsed = TRUE, # Set sidebar to be collapsed by default
    sidebarMenu(
      id = "tabs", # Added ID to sidebarMenu
      menuItem("Aim 1", tabName = "aim_1", icon = icon("dashboard")),
      menuItem("Aim 2", tabName = "aim_2", icon = icon("dashboard")),
      menuItem("Metric 1", tabName = "metric1_tab", icon = icon("alarm-clock")), #https://fontawesome.com/icons/packs/classic
      menuItem("Metric 2", tabName = "metric2_tab", icon = icon("line-chart")),
      menuItem("Metric 3", tabName = "metric3_tab", icon = icon("line-chart")),
      menuItem("Metric 4", tabName = "metric4_tab", icon = icon("line-chart")),
      menuItem("Metric 5", tabName = "metric5_tab", icon = icon("line-chart")),
      menuItem("Metric 6", tabName = "metric6_tab", icon = icon("line-chart")),
      menuItem("Metric 7", tabName = "metric7_tab", icon = icon("line-chart")),
      menuItem("Metric 8", tabName = "metric8_tab", icon = icon("line-chart")),
      menuItem("Metric 9", tabName = "metric9_tab", icon = icon("line-chart")),
      menuItem("Metric 10", tabName = "metric10_tab", icon = icon("line-chart")),
      menuItem("Metric 11", tabName = "metric11_tab", icon = icon("line-chart")),
      menuItem("Metric 12", tabName = "metric12_tab", icon = icon("line-chart")),
      menuItem("Metric 13", tabName = "metric13_tab", icon = icon("line-chart")),
      menuItem("Metric 14", tabName = "metric14_tab", icon = icon("line-chart"))
    )
  ),
  body = dashboardBody(
    tags$head(
      tags$style(HTML("
        /* Increase height of value boxes and add rounded corners */
        .small-box {
          height: 150px; /* Adjust height as needed */
          border-radius: 15px; /* Rounded corners */
        }
        /* Vertically center content within value box */
        .small-box .inner {
          display: flex;
          flex-direction: column;
          justify-content: center;
          height: 100%;
        }
        /* Adjust font size for value and subtitle if needed */
        .small-box h3 {
          font-size: 30px; /* Adjust font size for value */
        }
        .small-box p {
          font-size: 16px; /* Adjust font size for subtitle */
        }
        
      "))
    ),
    tabItems(
      tabItem(tabName = "aim_1", aim_1_tab_ui("aim_1")),
      tabItem(tabName = "aim_2", aim_2_tab_ui("aim_2")),
      tabItem(tabName = "metric1_tab", metric_1_ui("metric1")),
      tabItem(tabName = "metric2_tab", metric_2_ui("metric2")),
      tabItem(tabName = "metric3_tab", metric_3_ui("metric3")),
      tabItem(tabName = "metric4_tab", metric_4_ui("metric4")),
      tabItem(tabName = "metric5_tab", metric_5_ui("metric5")),
      tabItem(tabName = "metric6_tab", metric_6_ui("metric6")),
      tabItem(tabName = "metric7_tab", metric_7_ui("metric7")),
      tabItem(tabName = "metric8_tab", metric_8_ui("metric8")),
      tabItem(tabName = "metric9_tab", metric_9_ui("metric9")),
      tabItem(tabName = "metric10_tab", metric_10_ui("metric10")),
      tabItem(tabName = "metric11_tab", metric_11_ui("metric11")),
      tabItem(tabName = "metric12_tab", metric_12_ui("metric12")),
      tabItem(tabName = "metric13_tab", metric_13_ui("metric13")),
      tabItem(tabName = "metric14_tab", metric_14_ui("metric14"))
    ),
    # JavaScript to handle clicks on value boxes
    tags$script(HTML("
      $(document).on('click', '.clickable-box', function() {
        var tabName = $(this).data('tab-name');
        if (tabName) {
          Shiny.setInputValue('clicked_tab', tabName, {priority: 'event'});
        }
      });
    "))
  )
)

# Define server logic
server <- function(input, output, session) {
  aim_1_tab_server("aim_1", metric_data)
  aim_2_tab_server("aim_2", metric_data)
  metric_1_server("metric1", metric_data)
  metric_2_server("metric2", metric_data)
  metric_3_server("metric3", metric_data)
  metric_4_server("metric4", metric_data)
  metric_5_server("metric5", metric_data)
  metric_6_server("metric6", metric_data)
  metric_7_server("metric7", metric_data)
  metric_8_server("metric8", metric_data)
  metric_9_server("metric9", metric_data)
  metric_10_server("metric10", metric_data)
  metric_11_server("metric11", metric_data)
  metric_12_server("metric12", metric_data)
  metric_13_server("metric13", metric_data)
  metric_14_server("metric14", metric_data)
  
  # Observe clicks on value boxes and update tab
  observeEvent(input$clicked_tab, {
    updateTabItems(session, "tabs", selected = input$clicked_tab)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
