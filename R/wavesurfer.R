#' Create a soundwave visualization
#'
#' \code{wavesurfer} is an interactive soundwave player and visualizer with rich set of plugins and tools.
#' It works well with pipe (%>%) and can be used in Shiny, R Markdown and RStudio Viewer. It is an interface
#' of \href{https://wavesurfer-js.org}{'wavesurfer.js'} JavaScript library.
#'
#' @param audio todo.
#' @param audioContext todo.
#' @param audioRate todo.
#' @param audioScriptProcessor todo.
#' @param autoCenter todo.
#' @param backend todo.
#' @param backgroundColor todo.
#' @param barHeight todo.
#' @param barGap todo.
#' @param barWidth todo.
#' @param closeAudioContext todo.
#' @param container todo.
#' @param cursorColor todo.
#' @param cursorWidth todo.
#' @param duration todo.
#' @param fillParent todo.
#' @param forceDecode todo.
#' @param hideScrollbar todo.
#' @param interact todo.
#' @param loopSelection todo.
#' @param maxCanvasWidth todo.
#' @param mediaControls todo.
#' @param mediaType todo.
#' @param minPxPerSec todo.
#' @param normalize todo.
#' @param partialRender todo.
#' @param pixelRatio todo.
#' @param plugins todo.
#' @param progressColor todo.
#' @param removeMediaElementOnDestroy todo.
#' @param renderer todo.
#' @param responsive todo.
#' @param rtl todo.
#' @param scrollParent todo.
#' @param skipLength todo.
#' @param splitChannels todo.
#' @param waveColor todo.
#' @param xhr todo.
#' @param width todo.
#' @param height todo.
#' @param elementId todo.
#' @param annotations todo.
#' @param visualization todo.
#'
#' @import htmlwidgets
#'
#' @export
wavesurfer <- function(audio = NULL,
                       audioContext = NULL,
                       audioRate = 1,
                       audioScriptProcessor = NULL,
                       autoCenter = TRUE,
                       backend = 'WebAudio',
                       backgroundColor = NULL,
                       barHeight = 1,
                       barGap = NULL,
                       barWidth = NULL,
                       closeAudioContext = FALSE,
                       container = NULL,
                       cursorColor = '#333',
                       cursorWidth = 1,
                       duration = NULL,
                       fillParent = TRUE,
                       forceDecode = FALSE,
                       hideScrollbar = FALSE,
                       interact = TRUE,
                       loopSelection = TRUE,
                       maxCanvasWidth = 4000,
                       mediaControls = FALSE,
                       mediaType = 'audio',
                       minPxPerSec = 20,
                       normalize = FALSE,
                       partialRender = FALSE,
                       pixelRatio = NULL,
                       plugins = NULL,
                       progressColor = '#555',
                       removeMediaElementOnDestroy = TRUE,
                       renderer = NULL,
                       responsive = FALSE,
                       rtl = FALSE,
                       scrollParent = FALSE,
                       skipLength = 2,
                       splitChannels = FALSE,
                       waveColor = '#999',
                       xhr = list(),
                       width = NULL,
                       height = NULL,
                       elementId = NULL,
                       region_labeller = FALSE,
                       annotations = NULL,
                       visualization = 'wave',
                       spectrogram_colormap = 'magma') {

  settings = list(
    audioContext = audioContext,
    audioRate = audioRate,
    audioScriptProcessor = audioScriptProcessor,
    autoCenter = autoCenter,
    backend = backend,
    backgroundColor = backgroundColor,
    barHeight = barHeight,
    barGap = barGap,
    barWidth = barWidth,
    closeAudioContext = closeAudioContext,
    container = container,
    cursorColor = cursorColor,
    cursorWidth = cursorWidth,
    duration = duration,
    fillParent = fillParent,
    forceDecode = forceDecode,
    hideScrollbar = hideScrollbar,
    interact = interact,
    loopSelection = loopSelection,
    maxCanvasWidth = maxCanvasWidth,
    mediaControls = mediaControls,
    mediaType = mediaType,
    minPxPerSec = minPxPerSec,
    normalize = normalize,
    partialRender = partialRender,
    # pixelRatio = pixelRatio,
    plugins = plugins,
    progressColor = progressColor,
    removeMediaElementOnDestroy = removeMediaElementOnDestroy,
    # renderer = renderer,
    responsive = responsive,
    rtl = rtl,
    scrollParent = scrollParent,
    skipLength = skipLength,
    splitChannels = splitChannels,
    waveColor = waveColor,
    xhr = xhr,
    region_labeller = region_labeller,
    visualization = visualization,
    spectrogram_colormap = spectrogram_colormap
  )

  # mutating the format of the list
  if(!is.null(annotations)){
    annotations <- tidyr::nest(annotations, -start, -end, .key = "attributes")
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
#' @param example The example app to launch: "annotator", "microphone", "pluggins", "decoration".
#'
#' @export
runExample <- function(example = "annotator", display.mode = "showcase") {
  appDir <- system.file("example", package = "wavesurfer")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `wavesurfer`.", call. = FALSE)
  }

  shiny::runApp(paste0(appDir, "/", example, ".R"), display.mode = display.mode)
}


