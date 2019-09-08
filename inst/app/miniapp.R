library(shiny)
library(wavesurfer)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("mini app"),

  wavesurferOutput("meu_ws", height = "100%")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  output$meu_ws <- renderWavesurfer({

    wavesurfer(audio = "http://ia902606.us.archive.org/35/items/shortpoetry_047_librivox/song_cjrg_teasdale_64kb.mp3") %>%
      ws_set_wave_color('#55ffaa') %>%
      ws_spectrogram() %>%
      ws_cursor() %>%
      ws_regions()
  })

}

# Run the application
shinyApp(ui = ui, server = server)



