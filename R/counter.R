#' Counter Shiny Module UI
#' 
#' @param id (\code{character}) to describe the module
#' @param label (\code{character}) label on top of the button
#' 
#' @export
#' @import shiny
counterButton <- function(id, label = "Counter +1") {
  ns <- NS(id)
  tagList(
    actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )
}

#' Counter Shiny Module server
#' 
#' @param input shiny input
#' @param output shiny output
#' @param session shiny session
#' 
#' @return a number
#' 
#' @export
counter <- function(input, output, session) {
  count <- reactiveVal(0)
  observeEvent(input$button, {
    count(count() + 1)
  })
  output$out <- renderText({
    count()
  })
  count
}