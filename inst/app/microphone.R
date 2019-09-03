library(shiny)
library(wavesurfer)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Microphone"),

  actionButton("microphone", "Microphone", icon = icon("mic")),
  wavesurferOutput("meu_ws", height = "100%"),

  # actionButton("play", "Play", icon = icon("play")),
  # actionButton("pause", "Pause", icon = icon("pause")),
  # actionButton("mute", "Mute", icon = icon("times")),
  # actionButton("stop", "Stop", icon = icon("stop")),
  actionButton("microphone_start", "microphone_start", icon = icon("play")),
  actionButton("microphone_stop", "microphone_stop", icon = icon("stop")),
  tags$br(),
  verbatimTextOutput("input_data")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  output$meu_ws <- renderWavesurfer({
    wavesurfer(
      waveColor = 'black',
      interact = FALSE,
      cursorWidth = 0,
    )
  })

  observeEvent(input$play, {
    ws_play("meu_ws")
  })

  observeEvent(input$pause, {
    ws_pause("meu_ws")
  })

  observeEvent(input$mute, {
    ws_toggle_mute("meu_ws")
  })

  observeEvent(input$stop, {
    ws_stop("meu_ws")
  })

  observeEvent(input$microphone, {
    ws_microphone("meu_ws")
  })

  observeEvent(input$microphone_stop, {
    ws_microphone_stop("meu_ws")
  })

  observeEvent(input$microphone_start, {
    ws_microphone_start("meu_ws")
  })

  output$input_data <- renderPrint({
    reactiveValuesToList(input)
  })
}

# Run the application
shinyApp(ui = ui, server = server)



