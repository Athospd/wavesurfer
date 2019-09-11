.onLoad <- function(libname, pkgname) {
  shiny::registerInputHandler("regionsDF", function(data, ...) {

    data <- jsonlite::fromJSON(data)
    if(length(data) == 0) {
      tibble::tibble(start = numeric(0), end = numeric(0))
    } else {
      tibble::as_tibble(data)
    }
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

#' @importFrom utils packageVersion
tidyr_new_interface <- function() {
  utils::packageVersion("tidyr") > "0.8.99"
}
