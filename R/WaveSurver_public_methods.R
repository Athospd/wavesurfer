#' @export
ws_addRegions <- function(wavesurferId, annotations) {
  method <- "ws_addRegions"
  callJS()
}

#' @export
ws_play <- function(wavesurferId, start = NULL, end = NULL) {
  method <- "ws_play"
  callJS()
}

#' @export
ws_pause <- function(wavesurferId) {
  method <- "ws_pause"
  callJS()
}

#' @export
ws_playPause <- function(wavesurferId) {
  method <- "ws_playPause"
  callJS()
}

#' @export
ws_destroy <- function(wavesurferId) {
  method <- "ws_destroy"
  callJS()
}




