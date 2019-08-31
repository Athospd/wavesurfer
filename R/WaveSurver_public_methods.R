#' @export
ws_add_regions <- function(id, annotations) {
  method <- "ws_add_regions"
  callJS()
}

#' @export
ws_play <- function(id, start = NULL, end = NULL) {
  method <- "ws_play"
  callJS()
}

#' @export
ws_pause <- function(id) {
  method <- "ws_pause"
  callJS()
}

#' @export
ws_play_pause <- function(id) {
  method <- "ws_play_pause"
  callJS()
}

#' @export
ws_destroy <- function(id) {
  method <- "ws_destroy"
  callJS()
}

#' @export
ws_cancel_ajax <- function(id) {
  method <- "ws_cancel_ajax"
  callJS()
}

#' @export
ws_empty <- function(id) {
  method <- "ws_empty"
  callJS()
}

#' @export
ws_set_mute <- function(id, mute = TRUE) {
  method <- "ws_set_mute"
  callJS()
}

#' @export
ws_toggle_mute <- function(id) {
  method <- "ws_toggle_mute"
  callJS()
}

#' @export
ws_stop <- function(id) {
  method <- "ws_stop"
  callJS()
}

#' @export
ws_toggle_interaction <- function(id) {
  method <- "ws_toggle_interaction"
  callJS()
}

#' @export
ws_toggle_scroll <- function(id) {
  method <- "ws_toggle_scroll"
  callJS()
}

#' @export
ws_skip <- function(id, offset = NULL) {
  method <- "ws_skip"
  callJS()
}

#' @export
ws_skip_backward <- function(id, seconds = NULL) {
  method <- "ws_skip_backward"
  callJS()
}

#' @export
ws_skip_forward <- function(id, seconds = NULL) {
  method <- "ws_skip_forward"
  callJS()
}

#' @export
ws_set_wave_color <- function(id, color = NULL) {
  method <- "ws_set_wave_color"
  callJS()
}

#' @export
ws_set_progress_color <- function(id, color = NULL) {
  method <- "ws_set_progress_color"
  callJS()
}

#' @export
ws_set_cursor_color <- function(id, color = NULL) {
  method <- "ws_set_cursor_color"
  callJS()
}

#' @export
ws_set_background_color <- function(id, color = NULL) {
  method <- "ws_set_background_color"
  callJS()
}

#' @export
ws_set_volume <- function(id, new_volume = NULL) {
  method <- "ws_set_volume"
  callJS()
}

#' @export
ws_set_playback_rate <- function(id, rate = NULL) {
  method <- "ws_set_playback_rate"
  callJS()
}

#' @export
ws_set_height <- function(id, height = NULL) {
  method <- "ws_set_height"
  callJS()
}

#' @export
ws_zoom <- function(id, px_per_sec = NULL) {
  method <- "ws_zoom"
  callJS()
}

#' @export
ws_load <- function(id, url, peaks = NULL, preload = NULL, duration = NULL) {
  method <- "ws_load"
  callJS()
}

#' @export
ws_seek_to <- function(id, progress) {
  method <- "ws_seek_to"
  callJS()
}

#' @export
ws_seek_and_center <- function(id, progress) {
  method <- "ws_seek_and_center"
  callJS()
}
