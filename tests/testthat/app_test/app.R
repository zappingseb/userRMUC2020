source("../shinytest_load_pckg.R")

eval(shinytest_load_pckg("useRMUCDemo"))

ui <- fluidPage(
  counterButton("counter1", "Counter #1")
)

server <- function(input, output, session) {
  callModule(counter, "counter1")
}

shinyApp(ui, server)