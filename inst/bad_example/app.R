# ---- Data creation ----
experimental_data <- readRDS("experimental_data.rds")
# ---- Dependencies ----
if (!"dplyr" %in% installed.packages()[, "Package"]) {
  install.packages("dplyr")
}
if (!"ggplot2" %in% installed.packages()[, "Package"]) {
  install.packages("ggplot2")
}
library(dplyr)
library(ggplot2)

# ----- App Code ----

ui <- function() {
  fluidPage(
    selectInput("antibody", "Select an Antibody", choices = c("IgG", "IgA"), selected = "IgA", multiple = FALSE),
    tableOutput("summary_table"),
    plotOutput("distribution_plot")
  )
}

server <- function(input, output) {
  output$summary_table <- renderTable({
    experimental_data[[input$antibody]] %>%
      dplyr::group_by(treatment) %>%
      dplyr::summarise(
        mean = mean(meas),
        median = median(meas),
        lower_quantile = quantile(meas, 0.25),
        upper_quantile = quantile(meas, 0.75)
      )
  })
  
  output$distribution_plot <- renderPlot({
    ggplot(experimental_data[[input$antibody]], aes(x = meas, fill = treatment)) +
      geom_density(alpha = 0.5)
  })
}

shinyApp(ui, server)