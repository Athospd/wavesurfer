if(!require(shinyWidgets)) install.packages(shinyWidgets)
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
  titlePanel("Annotator"),

  tags$p(tags$strong("Wavs Folder:"), wav_folder),
  tags$p(tags$strong("Annotations Folder:"), annotation_folder),

  selectizeInput(
    "audio", "Audio:", width = "100%",
    choices = list.files(wav_folder)
  ),
  materialSwitch("spectrogram", "Bigger spectrogram", inline = TRUE),

  wavesurferOutput("my_ws"),

  fluidRow(
    column(
      width = 6,
      actionButton("play", "", icon = icon("play")),
      actionButton("pause", "", icon = icon("pause")),
      actionButton("stop", "", icon = icon("stop")),
      actionButton("skip_backward", "", icon = icon("backward")),
      actionButton("skip_forward", "", icon = icon("forward")),
      actionButton("mute", "", icon = icon("volume-off"))
    ),
    column(
      width = 6,
      actionButton("save", "Save", icon = icon("save")),
      actionButton("suggest_regions", "Suggest regions", icon = icon("cut")),
      actionButton("clear_regions", "Clear all regions", icon = icon("undo-alt"))
    ),
    column(
      width = 10,
      tags$hr(),
      tags$h4("input$my_ws_regions"),
      tableOutput("regions"),
      tags$hr()
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  wav_name <- reactive({
    stringr::str_replace(input$audio, "^wav/", "")
  })

  output$my_ws <- renderWavesurfer({
    req(!is.null(input$audio))

    # look if there is regions already annotated
    annotations_file <- stringr::str_replace_all(stringr::str_replace_all(input$audio, "wav$", "rds"), "^.*/", "")
    annotations_file <- paste0(annotation_folder, "/", annotations_file)

    if(file.exists(annotations_file)) {
      annotations_df <- readr::read_rds(annotations_file)
    } else {
      annotations_df <- NULL
    }

    wavesurfer(
      paste0("wav/",input$audio),
      annotations = annotations_df,
      visualization = 'spectrogram'
    ) %>%
      ws_annotator() %>%
      ws_minimap() %>%
      ws_cursor()
  })

  # controllers
  observeEvent(input$play, {ws_play("my_ws")})
  observeEvent(input$pause, {ws_pause("my_ws")})
  observeEvent(input$mute, {ws_toggle_mute("my_ws")})
  observeEvent(input$skip_forward, {ws_skip_forward("my_ws", 3)})
  observeEvent(input$skip_backward, {ws_skip_backward("my_ws", 3)})
  observeEvent(input$stop, {ws_stop("my_ws")})
  observe({ws_set_volume("my_ws", input$volume/50 )})
  observe({ws_zoom("my_ws", input$zoom )})

  # save
  observeEvent(input$save, {
    req(!is.null(wav_name()))

    annotations <- stringr::str_replace_all(wav_name(), "wav$", "rds")
    regions <- input$my_ws_regions %>% dplyr::mutate(sound_id = wav_name())
    readr::write_rds(x = regions, path = paste0(annotation_folder, "/", annotations))
  })

  # suggest regions
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

    names(suggested_annotations) <- c("sound_id", "region_id", "start", "end", "label")
    ws_add_regions("my_ws", suggested_annotations)
  })

  # clear all regions
  observeEvent(input$clear_regions, {ws_clear_regions("my_ws")})

  #bigger spectrogram
  observe({
    if(input$spectrogram) {
      ws_spectrogram("my_ws")
    } else {
      ws_destroy_spectrogram("my_ws")
    }
  })

  # the current region selected
  output$current_region <- renderTable({
    input$my_ws_selected_region
  }, width = "90%")

  # table of all regions
  output$regions <- renderTable({
    input$my_ws_regions
  }, width = "90%")
}

# Run the application
shinyApp(ui = ui, server = server)



