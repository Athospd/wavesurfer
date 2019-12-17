if(!require(shinyWidgets)) install.packages(shinyWidgets)
library(shiny)
library(wavesurfer)
library(reactable)

# set the folders of input wavs and output annotations
cat(getwd())
wav_folder <- normalizePath("/media/athos/DATA/OneDrive/Documents//mestrado/data-raw/wav_12khz/") # system.file("wav", package = "wavesurfer")
annotation_folder <- normalizePath("/media/athos/DATA/OneDrive/Documents/mestrado/data/anotacoes/") #tempdir()



# make it available to shiny
shiny::addResourcePath("wav", wav_folder)

ui <- fluidPage(

  # Application title
  titlePanel("Annotator"),
  fluidRow(
    column(
      width = 12,
      tags$p(tags$strong("Wavs Folder:"), wav_folder),
      tags$p(tags$strong("Annotations Folder:"), annotation_folder)
    ),
    column(
      width = 12,
      uiOutput("audio_ui"),
      shinyWidgets::materialSwitch("spectrogram", "Bigger spectrogram", inline = TRUE)
    )
  ),

  fluidRow(
    column(
      width = 12,
      wavesurferOutput("my_ws")
    ),
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
      shinyWidgets::materialSwitch("auto_save", "Autosave when switching audios", inline = TRUE),
      actionButton("suggest_regions", "Suggest regions", icon = icon("cut")),
      actionButton("clear_regions", "Clear all regions", icon = icon("undo-alt"))
    )
  ),
  tags$hr(),
  tabsetPanel(
    tabPanel(
      title = "Audios and regions",
      fluidRow(
        column(
          width = 4,
          reactable::reactableOutput("audios")
        ),
        column(
          width = 7,
          offset = 1,
          reactable::reactableOutput("regions")
        )
      )
    ),
    tabPanel(
      title = "debug",
      verbatimTextOutput("input")
    )
  ),
  tags$hr()
)


server <- function(input, output, session) {

  update_audio_df <- function() {

    tibble::tibble(
      file_name = list.files(wav_folder),
      annotated = file_name %in% stringr::str_replace_all(list.files(annotation_folder, ".rds$"), "rds$", "wav")
    )
  }

  audio_df <- reactiveVal(value = update_audio_df())
  selected_audio <- reactiveVal(as.character(update_audio_df()[1,"file_name", drop = TRUE]))

  output$audio_ui <- renderUI({
    shiny::p(shiny::strong("Current audio: "), selected_audio())
  })

  output$my_ws <- renderWavesurfer({
    req(!is.null(selected_audio()))

    # look if there is regions already annotated
    annotations_file <- stringr::str_replace_all(stringr::str_replace_all(selected_audio(), "wav$", "rds"), "^.*/", "")
    annotations_file <- paste0(annotation_folder, "/", annotations_file)

    if(file.exists(annotations_file)) {
      annotations_df <- readr::read_rds(annotations_file)
    } else {
      annotations_df <- NULL
    }

    wavesurfer(
      paste0("wav/", selected_audio()),
      annotations = annotations_df,
      visualization = 'spectrogram'
    ) %>%
      ws_annotator() %>%
      ws_minimap(height = 100, waveColor = "#F8766D", progressColor = "#00BFC4") %>%
      ws_cursor()
  })

  # controllers
  observeEvent(input$play, ws_play("my_ws"))
  observeEvent(input$pause, ws_pause("my_ws"))
  observeEvent(input$mute, ws_toggle_mute("my_ws"))
  observeEvent(input$skip_forward, ws_skip_forward("my_ws", 3))
  observeEvent(input$skip_backward, ws_skip_backward("my_ws", 3))
  observeEvent(input$stop, ws_stop("my_ws"))
  observe({ws_set_volume("my_ws", input$volume/50 )})
  observe({ws_zoom("my_ws", input$zoom )})

  # save
  save <- function(audio_file_name, regions_df) {
    annotations <- stringr::str_replace_all(audio_file_name, "wav$", "rds")
    regions <- regions_df %>% dplyr::mutate(audio_id = audio_file_name)
    readr::write_rds(x = regions, path = paste0(annotation_folder, "/", annotations))
  }

  # delete
  delete <- function(audio_file_name) {
    annotations <- stringr::str_replace_all(audio_file_name, "wav$", "rds")
    file.remove(paste0(annotation_folder, "/", annotations))
  }

  observeEvent(input$save, {
    req(!is.null(selected_audio()))

    save(selected_audio(), input$my_ws_regions)

    # update audio_df
    audio_df(update_audio_df())
  })



  # suggest regions
  observeEvent(input$suggest_regions, {

    wav <- tuneR::readWave(paste0(wav_folder, "/", selected_audio()))

    ## funcao do auto detector
    auto_detect_partial <- purrr::partial(
      warbleR::auto_detec,
      X = data.frame(sound.files = selected_audio(), selec = 1, start = 0, end = Inf),
      path = wav_folder,
      pb = FALSE
    )
    especies <- stringr::str_remove(selected_audio(), "-[0-9]*\\.wav$")
    auto_detect_parameters <- wavesurfer::birds$auto_detect_parameters[[especies]]

    ## segments founded
    suggested_annotations <- do.call(auto_detect_partial, auto_detect_parameters)
    suggested_annotations$sound.files <- selected_audio()

    if(is.null(suggested_annotations$label)) {
      suggested_annotations$label <- "(suggested region)"
    }

    names(suggested_annotations) <- c("audio_id", "id", "start", "end", "label")
    ws_add_regions("my_ws", suggested_annotations)
  })

  # clear all regions
  observeEvent(input$clear_regions, {
    ws_clear_regions("my_ws")
    delete(selected_audio())
    audio_df(update_audio_df())
  })

  # bigger spectrogram
  observe({
    if(input$spectrogram) {
      ws_spectrogram("my_ws")
    } else {
      ws_destroy_spectrogram("my_ws")
    }
  })

  # the current region selected
  output$current_region <- renderReactable({
    input$my_ws_selected_region %>% reactable()
  })

  # table of all regions
  output$regions <- renderReactable({
    req(nrow(input$my_ws_regions) > 0)

    input$my_ws_regions %>%
      reactable(
        selectionId = "regions_df_selected_region",
        resizable = TRUE,
        showPageSizeOptions = TRUE,
        onClick = "select",
        highlight = TRUE,
        compact = TRUE,
        selection = "single",
        columns = list(
          audio_id = reactable::colDef("audio_id", minWidth = 260),
          label = reactable::colDef("label", minWidth = 210),
          region_id = reactable::colDef("region_id", minWidth = 140),
          start = reactable::colDef("start", format = reactable::colFormat(digits = 2), width = 80),
          end = reactable::colDef("end", format = reactable::colFormat(digits = 2), width = 80)
        )
      )
  })

  # table of audios from wav_folder
  output$audios <- renderReactable({
    req(!is.null(audio_df()))
    audio_df() %>%
      reactable(
        selectionId = "audio_df_selected_row",
        resizable = TRUE,
        showPageSizeOptions = TRUE,
        onClick = "select",
        highlight = TRUE,
        compact = TRUE,
        selection = "single",
        filterable = TRUE,
        rowStyle = reactable::JS("function(a, b) {if(a.row.annotated) return {backgroundColor: '#8cff57'}}"),
        columns = list(
          annotated = reactable::colDef("Annotated", width = 100)
        )
      )
  })

  # when audio is switched
  observeEvent(input$audio_df_selected_row, {

    # if autosave is TRUE
    if(isolate(input$auto_save)) {
      save(isolate(selected_audio()), isolate(input$my_ws_regions))
    }

    selected_audio(audio_df() %>% dplyr::slice(as.numeric(input$audio_df_selected_row)) %>% dplyr::pull(file_name))
  })



  output$input <- renderPrint({
    reactiveValuesToList(input)
  })
}

# Run the application
shinyApp(ui = ui, server = server)



