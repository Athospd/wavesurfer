library(shiny)

ui <- fluidPage(
    wavesurferOutput("ws")
)

server <- function(input, output) {

    output$ws <- renderWavesurfer({
        wavesurfer('http://ia902606.us.archive.org/35/items/shortpoetry_047_librivox/song_cjrg_teasdale_64kb.mp3', waveColor = "#44dd55")
    })
}

# Run the application
shinyApp(ui = ui, server = server)
