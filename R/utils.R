.onLoad <- function(libname, pkgname) {
  shiny::registerInputHandler("regionsDF", function(data, ...) {
    jsonlite::fromJSON(data)
  })
}

is_called_inside_shiny <- function(session, context="") {
  if (is.null(session)) {
    stop(paste(context, "must be called from the server function of a Shiny app"))
  }
}

callJS <- function() {
  message <- Filter(function(x) !is.symbol(x), as.list(parent.frame(1)))
  session <- shiny::getDefaultReactiveDomain()
  is_called_inside_shiny(session, message$method)
  method <- paste0("wavesurfer:", message$method)
  session$sendCustomMessage(method, message)
}
