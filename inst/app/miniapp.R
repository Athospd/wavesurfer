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

    wavesurfer(
      audio = "http://ia902606.us.archive.org/35/items/shortpoetry_047_librivox/song_cjrg_teasdale_64kb.mp3",
        visualization = "spectrogram",
        backgroundColor = "#EBEBEB",
        cursorColor = "#FFFFFF",
        progressColor = "#00BFC4",
        waveColor = "#F8766D",
      height = 400
    ) %>%
      ws_minimap(height = 300, waveColor = "#F8766D", progressColor = "#00BFC4") %>%
      ws_cursor() %>%
      ws_annotator()
  })

}

# Run the application
shinyApp(ui = ui, server = server)



