library(shiny)
# Define UI
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(

    ),

    mainPanel()
  )
)

# Define server function
server <- function(input, output) {

}

# Create Shiny object
shinyApp(ui = ui, server = server)
