#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
wavesurfer <- function(audio,
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
                       annotations = NULL) {

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
    xhr = xhr
  )

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
    elementId = elementId
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
  htmltools::tags$div(id = id, style = style, class = class)
}

