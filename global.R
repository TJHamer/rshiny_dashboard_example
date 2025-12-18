library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

# Function to generate all initial dummy data
generate_all_metrics_data <- function() {
  # --- Generate Metric 2 time-series data ---
  quarters <- paste0("Q", 1:5)
  
  # Function to generate random data for 5 quarters for a given characteristic value
  gen_random_values <- function() {
    data.frame(
      Percentage = round(runif(5, 0, 100), 1),
      DaysPerWeek = round(runif(5, 0, 5), 1)
    )
  }
  
  all_metric2_data_long <- data.frame()
  
  # Overall
  overall_data <- gen_random_values()
  overall_data$Quarter <- quarters
  overall_data$CharacteristicType <- "Overall"
  overall_data$CharacteristicValue <- "Overall"
  all_metric2_data_long <- rbind(all_metric2_data_long, overall_data)
  
  # Gender
  for (gender in c("Male", "Female", "Other")) {
    gender_data <- gen_random_values()
    gender_data$Quarter <- quarters
    gender_data$CharacteristicType <- "Gender"
    gender_data$CharacteristicValue <- gender
    all_metric2_data_long <- rbind(all_metric2_data_long, gender_data)
  }
  
  # 9 UK Regions
  regions <- c("North East", "North West", "Yorkshire and the Humber", "East Midlands",
               "West Midlands", "East of England", "London", "South East", "South West")
  for (region in regions) {
    region_data <- gen_random_values()
    region_data$Quarter <- quarters
    region_data$CharacteristicType <- "Region"
    region_data$CharacteristicValue <- region
    all_metric2_data_long <- rbind(all_metric2_data_long, region_data)
  }
  
  # Height
  for (height in c("Big", "Small")) {
    height_data <- gen_random_values()
    height_data$Quarter <- quarters
    height_data$CharacteristicType <- "Height"
    height_data$CharacteristicValue <- height
    all_metric2_data_long <- rbind(all_metric2_data_long, height_data)
  }
  
  # Width
  for (width in c("Wide", "Narrow")) {
    width_data <- gen_random_values()
    width_data$Quarter <- quarters
    width_data$CharacteristicType <- "Width"
    width_data$CharacteristicValue <- width
    all_metric2_data_long <- rbind(all_metric2_data_long, width_data)
  }
  
  # Groups A-E
  for (group in LETTERS[1:5]) {
    group_data <- gen_random_values()
    group_data$Quarter <- quarters
    group_data$CharacteristicType <- "Group"
    group_data$CharacteristicValue <- group
    all_metric2_data_long <- rbind(all_metric2_data_long, group_data)
  }
  
  all_metric2_data_long$Quarter <- factor(all_metric2_data_long$Quarter, levels = quarters)
  
  # --- Generate static values for other metrics ---
  static_metrics <- list(
    metric1 = 100,
    metric3 = 300,
    metric4 = 400,
    metric5 = 500,
    metric6 = 600,
    metric7 = 700,
    metric8 = 800,
    metric9 = 900,
    metric10 = 1000,
    metric11 = 1100,
    metric12 = 1200,
    metric13 = 1300,
    metric14 = 1400
  )
  
  return(list(
    metric2_data = all_metric2_data_long,
    static_metrics = static_metrics
  ))
}

# Initialize all data
initial_data <- generate_all_metrics_data()

# Define the metric data as a reactive object
# This will be the single source of truth for all metric values
metric_data <- reactiveValues(
  metric2_data = initial_data$metric2_data,
  metric1 = initial_data$static_metrics$metric1,
  metric3 = initial_data$static_metrics$metric3,
  metric4 = initial_data$static_metrics$metric4,
  metric5 = initial_data$static_metrics$metric5,
  metric6 = initial_data$static_metrics$metric6,
  metric7 = initial_data$static_metrics$metric7,
  metric8 = initial_data$static_metrics$metric8,
  metric9 = initial_data$static_metrics$metric9,
  metric10 = initial_data$static_metrics$metric10,
  metric11 = initial_data$static_metrics$metric11,
  metric12 = initial_data$static_metrics$metric12,
  metric13 = initial_data$static_metrics$metric13,
  metric14 = initial_data$static_metrics$metric14
)

# Source module files
sapply(list.files("R", full.names = TRUE), source)