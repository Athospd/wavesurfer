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
      # annotations = data.frame(start = 1, end = 2, sound_id = "aff", segment_id = "opa", label = "boa")
    ) %>%
    # ws_spectrogram() %>%
    ws_timeline() %>%
    ws_minimap() %>%
    ws_regions() %>%
    ws_region_labeller()

  })

}

# Run the application
shinyApp(ui = ui, server = server)



