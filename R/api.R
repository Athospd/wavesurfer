#' ws_add_regions
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param annotations data.frame.
#'
#' @export
ws_add_regions <- function(id, annotations) {
  annotations <- tidyr::nest(annotations, -start, -end, .key = "attributes")
  method <- "ws_add_regions"
  callJS()
}

#' ws_clear_regions
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_clear_regions <- function(id) {
  method <- "ws_clear_regions"
  callJS()
}

#' ws_play
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param start numeric. The second of where it should start to play.
#' @param end numeric. The second of where it should stop to play.
#'
#' @export
ws_play <- function(id, start = NULL, end = NULL) {
  method <- "ws_play"
  callJS()
}

#' ws_pause
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_pause <- function(id) {
  method <- "ws_pause"
  callJS()
}

#' ws_play_pause
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_play_pause <- function(id) {
  method <- "ws_play_pause"
  callJS()
}

#' ws_destroy
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_destroy <- function(id) {
  method <- "ws_destroy"
  callJS()
}

#' ws_cancel_ajax
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_cancel_ajax <- function(id) {
  method <- "ws_cancel_ajax"
  callJS()
}

#' ws_empty
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_empty <- function(id) {
  method <- "ws_empty"
  callJS()
}

#' ws_set_mute
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param mute logical. Mute or unmute the sound. Default is TRUE (mute).
#'
#' @export
ws_set_mute <- function(id, mute = TRUE) {
  method <- "ws_set_mute"
  callJS()
}

#' ws_toggle_mute
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_toggle_mute <- function(id) {
  method <- "ws_toggle_mute"
  callJS()
}

#' ws_stop
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_stop <- function(id) {
  method <- "ws_stop"
  callJS()
}

#' ws_toggle_interaction
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_toggle_interaction <- function(id) {
  method <- "ws_toggle_interaction"
  callJS()
}

#' ws_toggle_scroll
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_toggle_scroll <- function(id) {
  method <- "ws_toggle_scroll"
  callJS()
}

#' ws_skip
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param offset numeric. How many seconds to skip. Can be nagative.
#'
#' @export
ws_skip <- function(id, offset = NULL) {
  method <- "ws_skip"
  callJS()
}

#' ws_skip_backward
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param seconds numeric. How many seconds to skip backward.
#'
#' @export
ws_skip_backward <- function(id, seconds = NULL) {
  method <- "ws_skip_backward"
  callJS()
}

#' ws_skip_forward
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param seconds numeric. How many seconds to skip forward.
#'
#' @export
ws_skip_forward <- function(id, seconds = NULL) {
  method <- "ws_skip_forward"
  callJS()
}

#' ws_set_wave_color
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param color character. Hex (e.g. #4466fa) or name of a color (e.g. 'blue').
#'
#' @export
ws_set_wave_color <- function(id, color = NULL) {
  method <- "ws_set_wave_color"
  callJS()
}

#' ws_set_progress_color
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param color character. Hex (e.g. #4466fa) or name of a color (e.g. 'blue').
#'
#' @export
ws_set_progress_color <- function(id, color = NULL) {
  method <- "ws_set_progress_color"
  callJS()
}

#' ws_set_cursor_color
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param color character. Hex (e.g. #4466fa) or name of a color (e.g. 'blue').
#'
#' @export
ws_set_cursor_color <- function(id, color = NULL) {
  method <- "ws_set_cursor_color"
  callJS()
}

#' ws_set_background_color
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param color character. Hex (e.g. #4466fa) or name of a color (e.g. 'blue').
#'
#' @export
ws_set_background_color <- function(id, color = NULL) {
  method <- "ws_set_background_color"
  callJS()
}

#' ws_set_volume
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param new_volume numeric. From 0 to 1.
#'
#' @export
ws_set_volume <- function(id, new_volume = NULL) {
  method <- "ws_set_volume"
  callJS()
}

#' ws_set_playback_rate
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param rate numeric.
#'
#' @export
ws_set_playback_rate <- function(id, rate = NULL) {
  method <- "ws_set_playback_rate"
  callJS()
}

#' ws_set_height
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param height numeric.
#'
#' @export
ws_set_height <- function(id, height = NULL) {
  method <- "ws_set_height"
  callJS()
}

#' ws_zoom
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param px_per_sec numeric. Pixels per second.
#'
#' @export
ws_zoom <- function(id, px_per_sec = NULL) {
  method <- "ws_zoom"
  callJS()
}

#' ws_load
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param url character of the url of the sound.
#' @param peaks numeric vector. The peaks to draw the soundwave.
#' @param preload logical.
#' @param duration numeric.
#'
#' @export
ws_load <- function(id, url, peaks = NULL, preload = NULL, duration = NULL) {
  method <- "ws_load"
  callJS()
}

#' ws_seek_to
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param progress numeric.
#'
#' @export
ws_seek_to <- function(id, progress) {
  method <- "ws_seek_to"
  callJS()
}

#' ws_seek_and_center
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param progress numeric.
#'
#' @export
ws_seek_and_center <- function(id, progress) {
  method <- "ws_seek_and_center"
  callJS()
}

#' ws_minimap
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_minimap <- function(id, parameters = NULL) {
  method <- "ws_minimap"
  callJS()
}

#' ws_regions
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_regions <- function(id, parameters = NULL) {
  method <- "ws_regions"
  callJS()
}

#' ws_elan
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_elan <- function(id, parameters = NULL) {
  method <- "ws_elan"
  callJS()
}

#' ws_timeline
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_timeline <- function(id, parameters = NULL) {
  method <- "ws_timeline"
  callJS()
}

#' ws_microphone
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_microphone <- function(id, parameters = NULL) {
  method <- "ws_microphone"
  callJS()
}

#' ws_spectrogram
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_spectrogram <- function(id, parameters = NULL) {
  method <- "ws_spectrogram"
  callJS()
}

#' ws_cursor
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param parameters list.
#'
#' @export
ws_cursor <- function(id, parameters = NULL) {
  method <- "ws_cursor"
  callJS()
}

#' ws_on
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param event character. The name of the event.
#' @param callback JS() object. A JavaScript callback function.
#' @param replace logical. Should the current callback be replaced?
#'
#' @export
ws_on <- function(id, event, callback = htmlwidgets::JS("function() {}"), replace = FALSE) {
  method <- "ws_on"
  callJS()
}

#' ws_un
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param event character. The name of the event.
#'
#' @export
ws_un <- function(id, event) {
  method <- "ws_un"
  callJS()
}

#' ws_un_all
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_un_all <- function(id) {
  method <- "ws_un_all"
  callJS()
}

#' ws_microphone_start
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_microphone_start <- function(id) {
  method <- "ws_microphone_start"
  callJS()
}

#' ws_microphone_stop
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_microphone_stop <- function(id) {
  method <- "ws_microphone_stop"
  callJS()
}

#' ws_region_labeller
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_region_labeller <- function(id, enable = TRUE) {
  method <- "ws_region_labeller"
  callJS()
}
