source("../shinytest_load_pckg.R")

eval(shinytest_load_pckg("useRMUCDemo"))

data(experimental_data)

ui <- fluidPage(
  summaryUI("counter1", dataset = experimental_data)
)

server <- function(input, output, session) {
  callModule(summaryServer, "counter1", dataset = experimental_data)
}

shinyApp(ui, server)