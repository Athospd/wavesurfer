if(!require(shinyWidgets)) install.packages(shinyWidgets)
library(shiny)
library(wavesurfer)

# set the folders of input wavs
wav_folder <- system.file("wav", package = "wavesurfer")

# make it available to shiny
shiny::addResourcePath("wav", wav_folder)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Plugins"),

  selectizeInput(
    "audio", "Audio ", width = "100%",
    choices = list.files(wav_folder)
  ),

  switchInput("minimap", "Minimap", inline = TRUE),
  switchInput("spectrogram", "spectrogram", inline = TRUE),
  switchInput("timeline", "timeline", inline = TRUE),
  switchInput("cursor", "cursor", inline = TRUE),
  actionButton("regions", "annotator", icon = icon("square")),
  tags$br(),
  wavesurferOutput("my_ws"),
  tags$br(),
  actionButton("play", "", icon = icon("play")),
  actionButton("pause", "", icon = icon("pause")),
  actionButton("stop", "", icon = icon("stop")),
  actionButton("skip_backward", "", icon = icon("backward")),
  actionButton("skip_forward", "", icon = icon("forward")),
  actionButton("mute", "", icon = icon("volume-off")),
  sliderInput("volume", "Volume", min = 0, max = 100, value = 50)
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  output$my_ws <- renderWavesurfer({
    wavesurfer(paste0("wav/",input$audio)) %>%
      ws_set_wave_color("royalblue") %>%
      ws_timeline()
  })

  # toggle plugins
  observe({if(input$minimap) ws_minimap("my_ws") else ws_destroy_minimap("my_ws")})
  observe({if(input$spectrogram) ws_spectrogram("my_ws") else ws_destroy_spectrogram("my_ws")})
  observe({if(input$timeline) ws_timeline("my_ws") else ws_destroy_timeline("my_ws")})
  observe({if(input$cursor) ws_cursor("my_ws") else ws_destroy_cursor("my_ws")})
  observeEvent(input$regions, {ws_annotator("my_ws")}) # not toggleable yet

  # controllers
  observeEvent(input$play, {ws_play("my_ws")})
  observeEvent(input$pause, {ws_pause("my_ws")})
  observeEvent(input$mute, {ws_toggle_mute("my_ws")})
  observeEvent(input$skip_forward, {ws_skip_forward("my_ws", 3)})
  observeEvent(input$skip_backward, {ws_skip_backward("my_ws", 3)})
  observeEvent(input$stop, {ws_stop("my_ws")})
  observe({ws_set_volume("my_ws", input$volume/50 )})
}

# Run the application
shinyApp(ui = ui, server = server)
