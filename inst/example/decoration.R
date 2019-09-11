if(!require(shinyWidgets)) install.packages(shinyWidgets)
if(!require(colourpicker)) install.packages(colourpicker)
library(shiny)
library(wavesurfer)

# set the folders of input wavs
wav_folder <- system.file("wav", package = "wavesurfer")

# make it available to shiny
shiny::addResourcePath("wav", wav_folder)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Wave Decorations"),
  sidebarLayout(
    sidebarPanel(
      radioGroupButtons(
        inputId = "visualization", label = "visualization",
        choices = c("wave", "bars", "spectrogram"),
        justified = FALSE, status = "default"
      ),
      conditionalPanel(
        condition = "input.visualization == 'bars'",
        sliderInput("barHeight", "barHeight", min = 0.1, max = 2, value = 1, step = 0.1),
        sliderInput("barGap", "barGap", min = 0.1, max = 5, value = 1, step = 0.1),
        sliderInput("barWidth", "barWidth", min = 0.1, max = 5, value = 2, step = 0.1)
      ),
      colourInput("backgroundColor", "backgroundColor", value = "#EBEBEB"),
      colourInput("waveColor", "waveColor", value = "#F8766D"),
      colourInput("progressColor", "progressColor", value = "#00BFC4"),
      colourInput("cursorColor", "cursorColor", value = "#FFFFFF"),
      switchInput("normalize", "normalize")
    ),
    mainPanel(
      selectizeInput(
        "audio", "Audio: ", width = "100%",
        choices = list.files(wav_folder)
      ),
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
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  output$my_ws <- renderWavesurfer({
    barWidth <- if(input$visualization == 'bars') barWidth <- input$barWidth else NULL


    wavesurfer(
      paste0("wav/",input$audio),
      barHeight = input$barHeight,
      barGap = input$barGap,
      barWidth = barWidth,
      visualization = input$visualization,
      normalize = input$normalize,
      backgroundColor = isolate(input$backgroundColor),
      cursorColor = isolate(input$cursorColor),
      progressColor = isolate(input$progressColor),
      waveColor = isolate(input$waveColor)
    ) %>%
      ws_skip_forward(10) %>%
      ws_cursor()
  })

  # decorators that do not rerender wavesurfer obj
  observe({input$my_ws_is_ready;ws_set_background_color("my_ws", input$backgroundColor)})
  observe({input$my_ws_is_ready;ws_set_cursor_color("my_ws", input$cursorColor)})
  observe({ws_set_progress_color("my_ws", input$progressColor)})
  observe({ws_set_wave_color("my_ws", input$waveColor)})

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
