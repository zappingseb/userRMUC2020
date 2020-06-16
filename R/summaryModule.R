#' Counter Shiny Module UI
#' 
#' @param id (\code{character}) to describe the module
#' @param dataset (\code{list}) A list of data.frames with two columns
#' 
#' @export
#' @import shiny
summaryUI <- function(id, dataset = list()) {
  ns <- NS(id)
  tagList(
    selectInput(
      ns("antibody"),
      "Select an Antibody",
      choices = names(dataset),
      selected = names(dataset)[1],
      multiple = FALSE
    ),
    tableOutput(ns("summary_table")),
    plotOutput(ns("distribution_plot"))
  )
}

#' Counter Shiny Module server
#' 
#' @param input shiny input
#' @param output shiny output
#' @param session shiny 
#' @param dataset (\code{list}) A list of data.frames with two columns
#' 
#' @return a number
#' 
#' @export
summaryServer <- function(input, output, session, dataset) {
  output$summary_table <- renderTable({
    summary_table(dataset[[input$antibody]][, 1], dataset[[input$antibody]][, 2])
  })
  
  output$distribution_plot <- renderPlot({
    summary_plot(dataset[[input$antibody]][, 1], dataset[[input$antibody]][, 2])
  })
}