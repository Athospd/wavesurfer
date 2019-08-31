.onLoad <- function(libname, pkgname) {
  shiny::registerInputHandler("regionsDF", function(data, ...) {
    jsonlite::fromJSON(data)
  })
}

callJS <- function() {
  message <- Filter(function(x) !is.symbol(x), as.list(parent.frame(1)))
  session <- shiny::getDefaultReactiveDomain()
  if (methods::is(message$id, "wavesurfer")) {
    widget <- message$id
    message$id <- NULL
    widget$x$api <- c(widget$x$api, list(message))
    return(widget)
  } else if (is.character(message$id)) {
    method <- paste0("wavesurfer:", message$method)
    session$sendCustomMessage(method, message)
    return(message$id)
  } else {
    stop("The `id` argument must be either a wavesurfer htmlwidget or an ID of a wavesurfer htmlwidget.", call. = FALSE)
  }
}