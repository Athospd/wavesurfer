library(shiny)
library(wavesurfer)

# set the folders of input wavs and output annotations
wav_folder <- system.file("wav", package = "wavesurfer")
annotation_folder <- tempdir()

# make it available to shiny
shiny::addResourcePath("wav", wav_folder)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Anotador"),

  uiOutput("wav_files"),

  actionButton("minimap", "Minimap", icon = icon("map")),
  actionButton("spectrogram", "spectrogram", icon = icon("chart")),
  tags$br(),
  wavesurferOutput("my_ws"),
  tags$br(),
  actionButton("play", "Play", icon = icon("play")),
  actionButton("pause", "Pause", icon = icon("pause")),
  actionButton("mute", "Mute", icon = icon("times")),
  actionButton("stop", "Stop", icon = icon("stop")),
  actionButton("save", "Save", icon = icon("save")),
  actionButton("suggest_regions", "Suggest regions", icon = icon("cut")),
  tags$br(),
  sliderInput("zoom", "Zoom", min = 1, max = 1000, value = 50),
  tags$br(),
  verbatimTextOutput("regions"),
  verbatimTextOutput("current_region"),
  verbatimTextOutput("inputs_available")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  wav_name <- reactive({
    stringr::str_replace(input$audio, "^wav/", "")
  })

  output$wav_files <- renderUI({
    selectizeInput(
      "audio", "Audio: ", width = "100%",
      choices = list.files(wav_folder)
    )
  })

  output$my_ws <- renderWavesurfer({
    req(!is.null(input$audio))

    # look if there is regions already annotated
    annotations_file <- stringr::str_replace_all(stringr::str_replace_all(input$audio, "wav$", "rds"), "^.*/", "")
    annotations_file <- paste0(annotation_folder, annotations_file)
    if(file.exists(annotations_file)) {
      annotations_df <- readr::read_rds(annotations_file)
    } else {
      annotations_df <- NULL
    }

    wavesurfer(
      paste0("wav/",input$audio),
      annotations = annotations_df,
      waveColor = "#cc33aa",
      visualization = 'spectrogram'
    ) %>%
      ws_annotator()
  })

  # controllers
  observeEvent(input$play, {ws_play("my_ws")})
  observeEvent(input$pause, {ws_pause("my_ws")})
  observeEvent(input$mute, {ws_toggle_mute("my_ws")})
  observeEvent(input$stop, {ws_stop("my_ws")})
  observeEvent(input$minimap, {ws_minimap("my_ws")})
  observeEvent(input$spectrogram, {ws_spectrogram("my_ws")})
  observeEvent(input$regions, {ws_regions("my_ws")})
  observe({ws_zoom("my_ws", input$zoom)})

  observeEvent(input$save, {
    req(!is.null(wav_name()))

    annotations <- stringr::str_replace_all(wav_name(), "wav$", "rds")
    regions <- input$my_ws_regions %>% dplyr::mutate(sound_id = wav_name())
    readr::write_rds(x = regions, path = paste0(annotation_folder, "/", annotations))
  })

  observeEvent(input$suggest_regions, {

    wav <- tuneR::readWave(paste0(wav_folder, "/", wav_name()))

    ## funcao do auto detector
    auto_detect_partial <- purrr::partial(
      warbleR::auto_detec,
      X = data.frame(sound.files = wav_name(), selec = 1, start = 0, end = Inf),
      path = wav_folder,
      pb = FALSE
    )
    especies <- stringr::str_remove(wav_name(), "-[0-9]*\\.wav$")
    auto_detect_parameters <- wavesurfer::birds$auto_detect_parameters[[especies]]

    ## segments founded
    suggested_annotations <- do.call(auto_detect_partial, auto_detect_parameters)
    suggested_annotations$sound.files <- wav_name()

    if(is.null(suggested_annotations$label)) {
      suggested_annotations$label <- "(suggested region)"
    }

    names(suggested_annotations) <- c("sound_id", "segmentation_id", "start", "end", "label")
    ws_add_regions("my_ws", suggested_annotations)
  })

  output$current_region <- renderPrint({
    input$my_ws_selected_region
  })

  output$regions <- renderPrint({
    input$my_ws_regions
  })

  output$inputs_available <- renderPrint({
    reactiveValuesToList(input)
  })
}

# Run the application
shinyApp(ui = ui, server = server)



