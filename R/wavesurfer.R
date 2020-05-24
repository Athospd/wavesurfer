#' Create a soundwave visualization
#'
#' \code{wavesurfer} is an interactive soundwave player and visualizer with rich set of
#' plugins and tools. It works well with pipe (%>%) and can be used in Shiny. It is an interface of \href{https://wavesurfer-js.org}{'wavesurfer.js'}
#' JavaScript library and it is based on \href{http://www.htmlwidgets.org/}{'htmlwidgets'} R package.
#'
#' See also \href{https://wavesurfer-js.org/docs/options.html}{https://wavesurfer-js.org/docs/options.html}
#' for the original JS documentation.
#'
#' @param audio a character. A path or a URL for the audio. E.g. "path/to/audio.mp3"
#'  or "https://wavesurfer-js.org/example/media/demo.wav".
#' @param playPauseWithSpaceBar a logical. If TRUE, spacebar toggle play/pause. Default is TRUE.
#' @param audioRate a numeric. Speed at which to play audio. Lower number is
#' slower. Default is 1.
#' @param autoCenter If a scrollbar is present, center the waveform around the
#' progress. Defaults to TRUE.
#' @param backgroundColor todo.
#' @param barHeight a numeric. Height of the waveform bars. Higher number than 1
#' will increase the waveform bar heights. Default is 1.
#' @param barGap a numeric. The optional spacing between bars of the wave.
#' @param barWidth a numeric. If specified, the waveform will be drawn like
#' this: ▁ ▂ ▇ ▃ ▅ ▂
#' @param cursorColor a character. The fill color of the cursor indicating the playhead
#' position. Default is '#333333'.
#' @param fillParent a logical. Whether to fill the entire container or draw only
#' according to minPxPerSec. Defaults to TRUE.
#' @param forceDecode a logical. Force decoding of audio using web audio when
#' zooming to get a more detailed waveform. Defaults to FALSE.
#' @param hideScrollbar a logical. Whether to hide the horizontal scrollbar when one
#' would normally be shown. Defaults to FALSE.
#' @param interact  a logical. Whether the mouse interaction will be enabled at
#' initialization. Defaults to TRUE.
#' @param loopSelection a logical. (Use with regions plugin) Enable looping of selected
#' regions. Defaults to TRUE.
#' @param maxCanvasWidth a numeric. Maximum width of a single canvas in pixels, excluding
#' a small overlap (`2 * pixelRatio`,
#' rounded up to the next even integer). If the waveform is longer than this value,
#' additional canvases will be used to render the waveform, which is useful for very
#' large waveforms that may be too wide for browsers to draw on a single canvas. This
#' parameter is only applicable to the `MultiCanvas` renderer.
#' @param minPxPerSec a numeric. Minimum number of pixels per second of audio.
#' Default is 50.
#' @param normalize a logical. If TRUE, normalize by the maximum peak instead of 1.
#' @param progressColor a character. The fill color of the part of the waveform
#' behind the cursor. When `progressColor` and `waveColor` are
#' the same the progress wave is not rendered at all. Default is '#555555'.
#' @param responsive a logical. If set to TRUE resize the waveform, when
#' the window is resized. This is debounced with a 100ms timeout by default.
#' If this parameter is a number it represents that timeout.
#' @param rtl todo.
#' @param scrollParent a logical. Whether to scroll the container with a
#' lengthy waveform. Otherwise the waveform is shrunk to the container width
#' (see `fillParent`). Defaults to FALSE.
#' @param skipLength a numeric. Number of seconds to skip with the
#' \code{\link[wavesurfer]{ws_skip_forward}} and \code{\link[wavesurfer]{ws_skip_backward}}
#' functions. Default is 2 seconds.
#' @param splitChannels a logical. Render with seperate waveforms for the
#' channels of the audio. Defaults to FALSE.
#' @param waveColor a character. The fill color of the waveform after the
#' cursor. Default is '#999999'.
#' @param width Fixed width for timeline (in css units).
#' @param height Fixed height for timeline (in css units).
#' @param elementId Use an explicit element ID for the widget (rather than an
#' automatically generated one). Ignored when used in a Shiny app.
#' @param annotations a data.frame with columns "audio_id" (character), "region_id"
#' (character), "start" (numeric), "end" (numeric), "label" (character). The rows
#' represents the annotated regions of the audio.
#' @param visualization a character. Either 'wave' or 'spectrogram'. The type of
#' the main visualization. Default is 'wave'.
#'
#'@section Plugins:
#' The following plugins are implemented:
#' \itemize{
#'   \item{\strong{\code{\link[wavesurfer]{ws_regions}}}} - Adds ability to display
#'   and interact with audio regions. Regions are visual overlays that can be resized
#'   and dragged around the waveform. See also \strong{\code{\link[wavesurfer]{ws_annotator}}}
#'   for a nice feature to annotate regions with ease.
#'   \item{\strong{\code{\link[wavesurfer]{ws_timeline}}}} - Adds a nice simple timeline to
#'   your waveform. By \href{https://github.com/instajams}{Instajams}.
#'   \item{\strong{\code{\link[wavesurfer]{ws_minimap}}}} - Adds a minimap preview of your waveform. By \href{https://github.com/entonbiba}{Enton Biba}.
#'   \item{\strong{\code{\link[wavesurfer]{ws_spectrogram}}}} - Shows a spectrogram for your waveform right below it.
#'   \item{\strong{\code{\link[wavesurfer]{ws_cursor}}}} - Shows a cursor on your waveform.
#'   \item{\strong{\code{\link[wavesurfer]{ws_microphone}}}} - Visualizes audio input from a microphone. By \href{https://github.com/thijstriemstra}{Thijs Triemstra}.
#' }
#'
#' @return A wavesurfer visualization \code{htmlwidgets} object
#'
#' @examples
#' if (interactive()) {
#'
#'   library(wavesurfer)
#'
#'   # set the folders of input wavs and output annotations
#'   wavs_folder <- system.file("wav", package = "wavesurfer")
#'   annotation_folder <- tempdir()
#'
#'   # make it available to shiny
#'   shiny::addResourcePath("wav", wavs_folder)
#'
#'   # Define UI for application that draws a histogram
#'   ui <- fluidPage(
#'
#'     # Application title
#'     titlePanel("Anotador"),
#'
#'     uiOutput("wav_files"),
#'
#'     actionButton("minimap", "Minimap", icon = icon("map")),
#'     actionButton("spectrogram", "spectrogram", icon = icon("chart")),
#'     tags$br(),
#'     wavesurferOutput("my_ws"),
#'     tags$br(),
#'     actionButton("play", "Play", icon = icon("play")),
#'     actionButton("pause", "Pause", icon = icon("pause")),
#'     actionButton("mute", "Mute", icon = icon("times")),
#'     actionButton("stop", "Stop", icon = icon("stop")),
#'     actionButton("save", "Save", icon = icon("save")),
#'     actionButton("suggest_regions", "Suggest regions", icon = icon("cut")),
#'     tags$br(),
#'     sliderInput("zoom", "Zoom", min = 1, max = 1000, value = 50),
#'     tags$br(),
#'     verbatimTextOutput("regions"),
#'     verbatimTextOutput("current_region"),
#'     verbatimTextOutput("inputs_available")
#'   )
#'
#'   # Define server logic required to draw a histogram
#'   server <- function(input, output, session) {
#'
#'     wav_name <- reactive({
#'       stringr::str_replace(input$audio, "^wav/", "")
#'     })
#'
#'     output$wav_files <- renderUI({
#'       selectizeInput(
#'         "audio", "Audio: ", width = "100%",
#'         choices = list.files(wavs_folder)
#'       )
#'     })
#'
#'     output$my_ws <- renderWavesurfer({
#'       req(!is.null(input$audio))
#'
#'       # look if there is regions already annotated
#'       annotations_file <- stringr::str_replace_all(stringr::str_replace_all(input$audio, "wav$", "rds"), "^.*/", "")
#'       annotations_file <- paste0(annotation_folder, annotations_file)
#'       if(file.exists(annotations_file)) {
#'         annotations_df <- readr::read_rds(annotations_file)
#'       } else {
#'         annotations_df <- NULL
#'       }
#'
#'       wavesurfer(
#'         paste0("wav/",input$audio),
#'         annotations = annotations_df,
#'         waveColor = "#cc33aa",
#'         visualization = 'spectrogram'
#'       ) %>%
#'         ws_annotator()
#'     })
#'
#'     # controllers
#'     observeEvent(input$play, {ws_play("my_ws")})
#'     observeEvent(input$pause, {ws_pause("my_ws")})
#'     observeEvent(input$mute, {ws_toggle_mute("my_ws")})
#'     observeEvent(input$stop, {ws_stop("my_ws")})
#'     observeEvent(input$minimap, {ws_minimap("my_ws")})
#'     observeEvent(input$spectrogram, {ws_spectrogram("my_ws")})
#'     observeEvent(input$regions, {ws_regions("my_ws")})
#'     observe({ws_zoom("my_ws", input$zoom)})
#'
#'     observeEvent(input$save, {
#'       req(!is.null(wav_name()))
#'
#'       annotations <- stringr::str_replace_all(wav_name(), "wav$", "rds")
#'       regions <- input$my_ws_regions %>% dplyr::mutate(audio_id = wav_name())
#'       readr::write_rds(x = regions, path = paste0(annotation_folder, "/", annotations))
#'     })
#'
#'     observeEvent(input$suggest_regions, {
#'
#'       wav <- tuneR::readWave(paste0(wavs_folder, "/", wav_name()))
#'
#'       ## funcao do auto detector
#'       auto_detect_partial <- purrr::partial(
#'         warbleR::auto_detec,
#'         X = data.frame(sound.files = wav_name(), selec = 1, start = 0, end = Inf),
#'         path = wavs_folder,
#'         pb = FALSE
#'       )
#'       especies <- stringr::str_remove(wav_name(), "-[0-9]*\\.wav$")
#'       auto_detect_parameters <- wavesurfer::birds$auto_detect_parameters[[especies]]
#'
#'       ## segments founded
#'       suggested_annotations <- do.call(auto_detect_partial, auto_detect_parameters)
#'       suggested_annotations$sound.files <- wav_name()
#'
#'       if(is.null(suggested_annotations$label)) {
#'         suggested_annotations$label <- "(suggested region)"
#'       }
#'
#'       names(suggested_annotations) <- c("audio_id", "region_id", "start", "end", "label")
#'       ws_add_regions("my_ws", suggested_annotations)
#'     })
#'
#'     output$current_region <- renderPrint({
#'       input$my_ws_selected_region
#'     })
#'
#'     output$regions <- renderPrint({
#'       input$my_ws_regions
#'     })
#'
#'     output$inputs_available <- renderPrint({
#'       reactiveValuesToList(input)
#'     })
#'   }
#'
#'   shinyApp(ui = ui, server = server)
#' }
#'
#' @import htmlwidgets
#'
#' @export
wavesurfer <- function(audio = NULL,
                       playPauseWithSpaceBar = TRUE,
                       audioRate = 1,
                       autoCenter = TRUE,
                       backgroundColor = NULL,
                       barHeight = 1,
                       barGap = NULL,
                       barWidth = NULL,
                       cursorColor = '#333',
                       fillParent = TRUE,
                       forceDecode = FALSE,
                       hideScrollbar = FALSE,
                       interact = TRUE,
                       loopSelection = TRUE,
                       maxCanvasWidth = 4000,
                       minPxPerSec = 20,
                       normalize = FALSE,
                       progressColor = '#555',
                       responsive = FALSE,
                       scrollParent = FALSE,
                       skipLength = 2,
                       splitChannels = FALSE,
                       waveColor = '#999',
                       width = NULL,
                       height = NULL,
                       elementId = NULL,
                       annotations = NULL,
                       visualization = 'wave') {

  settings = list(
    playPauseWithSpaceBar = playPauseWithSpaceBar,
    audioRate = audioRate,
    autoCenter = autoCenter,
    backgroundColor = backgroundColor,
    barHeight = barHeight,
    barGap = barGap,
    barWidth = barWidth,
    cursorColor = cursorColor,
    fillParent = fillParent,
    forceDecode = forceDecode,
    hideScrollbar = hideScrollbar,
    interact = interact,
    loopSelection = loopSelection,
    maxCanvasWidth = maxCanvasWidth,
    minPxPerSec = minPxPerSec,
    normalize = normalize,
    progressColor = progressColor,
    responsive = responsive,
    scrollParent = scrollParent,
    skipLength = skipLength,
    splitChannels = splitChannels,
    waveColor = waveColor,
    visualization = visualization
  )

  # mutating the format of the list
  if(!is.null(annotations)) {
    if(tidyr_new_interface()) {
      annotations <- tidyr::nest(annotations, attributes = c(audio_id, region_id, label))
    } else {
      annotations <- tidyr::nest(annotations, audio_id, region_id, label, .key = "attributes")
    }
  }

  # forward options using x
  x = list(
    audio = audio,
    settings = settings,
    annotations = annotations
  )

  x$api <- list()

  # create widget
  htmlwidgets::createWidget(
    name = 'wavesurfer',
    x,
    width = width,
    height = height,
    package = 'wavesurfer',
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      defaultHeight = "100%",
      viewer.fill = TRUE,
      browser.fill = TRUE,
      knitr.defaultWidth = 700
    )
  )
}

#' Shiny bindings for wavesurfer
#'
#' Output and render functions for using wavesurfer within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a wavesurfer
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name wavesurfer-shiny
#'
#' @export
wavesurferOutput <- function(outputId, width = '100%', height = '128px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'wavesurfer', width, height, package = 'wavesurfer')
}

#' @rdname wavesurfer-shiny
#' @export
renderWavesurfer <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, wavesurferOutput, env, quoted = TRUE)
}

wavesurfer_html <- function(id, style, class, ...) {
  htmltools::tagList(
    htmltools::tags$div(id = paste0(id, "-timeline"), style = "display: 'none'", class = class),
    htmltools::tags$div(id = id, style = style, class = class),
    htmltools::tags$div(id = paste0(id, "-spectrogram"), style = "display: 'none'", class = class),
    shiny::selectizeInput(
      inputId = paste0(id, "_region_labeller"),
      label = "Region labeller",
      choices = c(),
      options = list(create = TRUE)
    )
  )
}

#' runExample
#'
#' Launch shiny example applications.
#'
#' @param display.mode The mode in which to display the example. Defaults to showcase, but may be set to normal to see the example without code or commentary.
#' @param example The example app to launch: "annotator", "microphone", "plugins", "decoration".
#'
#' @export
runExample <- function(example = c("annotator", "microphone", "plugins", "decoration"), display.mode = "showcase") {
  appDir <- system.file("example", package = "wavesurfer")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `wavesurfer`.", call. = FALSE)
  }

  shiny::runApp(paste0(appDir, "/", example[1], ".R"), display.mode = display.mode)
}

#' anotador_app
#'
#' @param wavs_folder
#' @param annotations_folder
#'
#' @import shiny
#' @export
annotator_app <- function(wavs_folder, annotations_folder = getwd(), labels = NULL) {
  wavs_folder <- normalizePath(wavs_folder) # system.file("wav", package = "wavesurfer")
  annotation_folder <- normalizePath(annotations_folder) #tempdir()

  # make it available to shiny
  shiny::addResourcePath("wav", wavs_folder)

  ui <- fluidPage(
    tags$head(
      tags$style(type="text/css", ".inline label{ display: table-cell; text-align: left; vertical-align: middle; }
                 .inline .form-group{display: table-row;}")
    ),
    shinyjs::useShinyjs(),

    # Application title
    titlePanel("Annotator"),
    fluidRow(
      column(
        width = 12,
        tags$p(tags$strong("Wavs Folder:"), wavs_folder),
        tags$p(tags$strong("Annotations Folder:"), annotation_folder)
      ),
      column(
        width = 12,
        uiOutput("audio_ui"),
        shinyWidgets::materialSwitch("spectrogram", "Bigger spectrogram", inline = TRUE),
        shinyWidgets::materialSwitch("auto_save", "Autosave when switching audios", inline = TRUE),
        actionButton("save", "Save", icon = icon("save"), class = "btn-success")
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
        tags$div(
          tags$div(
            style = "display: inline-block;",
            shinyWidgets::dropdownButton(
              circle = FALSE, status = "success", icon = icon("gear"), size = "default",
              tags$h4("Setup"),
              sliderInput("wl", "Window Length: ", 64, 1024, 512, 2),
              sliderInput("ovlp", "Overlap: ", 0, 50, 50, 2, post = "%"),
              sliderInput("threshold", "Threshold: ", 0, 100, 15, 1),
              sliderInput("ssmooth", "Ssmooth: ", 100, 10000, 1500, 100),
              sliderInput("mindur", "Min duration (s): ", 0.05, 10, 0.2, 0.05),
              sliderInput("maxdur", "Max duration (s): ", 0.05, 10, 0.8, 0.05),
              sliderInput("bp", "Band pass (khz): ", 0, 10, c(1.20, 1.55), 0.01),
              selectizeInput("envt", "Envelope: ", choices = c("Hilbert" = "hil", "Absolute" = "abs"))
            )
          ),
          tags$div(
            style = "display: inline-block;",
            actionButton("suggest_regions", "Suggest regions", icon = icon("cut"), style = "display: inline-block;",),
            actionButton("clear_regions", "Clear all regions", icon = icon("undo-alt"), style = "display: inline-block;",),
            tags$div(style = "display: inline;", class = "inline", textInput("default_label_of_suggested_regions", "Default label: ", "suggested_region"))
          )
        ),
        tags$p(id = "suggest_regions_msg_wait", "looking for regions, please wait...", style = "display: inline; vertical-align: sub;", class = "text-warning") %>% shinyjs::hidden(),
        tags$p(id = "suggest_regions_msg_success", "Done!", style = "display: inline; vertical-align: sub;", class = "text-success") %>% shinyjs::hidden(),
        tags$p(id = "suggest_regions_msg_fail", "Done. No regions found.", style = "display: inline; vertical-align: sub;", class = "text-danger") %>% shinyjs::hidden()

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
        file_name = list.files(wavs_folder),
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
        ws_annotator(labels = labels) %>%
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

      if(nrow(regions_df) > 0) {
        readr::write_rds(x = regions, path = paste0(annotation_folder, "/", annotations))
      }
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

    observeEvent(selected_audio(), {
      shinyjs::hide("suggest_regions_msg_wait")
      shinyjs::hide("suggest_regions_msg_fail")
      shinyjs::hide("suggest_regions_msg_success")
    })

    # suggest regions
    observeEvent(input$suggest_regions, {
      shinyjs::disable("suggest_regions")
      shinyjs::show("suggest_regions_msg_wait")
      shinyjs::hide("suggest_regions_msg_fail")
      shinyjs::hide("suggest_regions_msg_success")

      wav <- tuneR::readWave(paste0(wavs_folder, "/", selected_audio()))

      ## segments founded
      suggested_annotations <- warbleR::auto_detec(
        X = data.frame(sound.files = selected_audio(), selec = 1, start = 0, end = Inf),
        path = wavs_folder,
        pb = FALSE,
        bp = input$bp,
        envt = input$envt,
        mindur = input$mindur,
        maxdur = input$maxdur,
        ssmooth = input$ssmooth,
        threshold = input$threshold,
        wl = input$wl,
        ovlp = input$ovlp,
        img = FALSE
      )

      suggested_annotations$label <- input$default_label_of_suggested_regions
      names(suggested_annotations) <- c("audio_id", "region_id", "start", "end", "label")
      suggested_annotations$region_id <- replicate(nrow(suggested_annotations), tempfile(tmpdir = "", pattern = "wavesurfer_") %>% substr(2, 23))

      shinyjs::hide("suggest_regions_msg_wait")
      shinyjs::enable("suggest_regions")

      if(!any(is.na(suggested_annotations$start))) {
        ws_add_regions("my_ws", suggested_annotations)
        shinyjs::show("suggest_regions_msg_success")
      } else {
        shinyjs::show("suggest_regions_msg_fail")
      }
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


    # table of all regions
    output$regions <- reactable::renderReactable({
      req(nrow(input$my_ws_regions) > 0)

      input$my_ws_regions %>%
        reactable::reactable(
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

    # table of audios from wavs_folder
    output$audios <- reactable::renderReactable({
      req(!is.null(audio_df()))
      audio_df() %>%
        reactable::reactable(
          selectionId = "audio_df_selected_row",
          resizable = TRUE,
          showPageSizeOptions = TRUE,
          onClick = "select",
          highlight = TRUE,
          compact = TRUE,
          selection = "single",
          filterable = TRUE,
          defaultPageSize = 7,
          rowStyle = reactable::JS("function(a, b) {if(a.row.annotated) return {backgroundColor: '#8cff57'}}"),
          columns = list(
            annotated = reactable::colDef("Annotated", width = 100)
          )
        )
    })

    # when audio is switched
    observeEvent(input$audio_df_selected_row, {

      # if autosave is TRUE
      if((input$auto_save)) {
        save((selected_audio()), (input$my_ws_regions))

        # update audio_df
        audio_df(update_audio_df())
      }

      selected_audio(audio_df() %>% dplyr::slice(as.numeric(input$audio_df_selected_row)) %>% dplyr::pull(file_name))
    })

    output$input <- renderPrint({
      reactiveValuesToList(input)
    })
  }

  # Run the application
  shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
}
