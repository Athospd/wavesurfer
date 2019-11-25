#' ws_add_regions
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param annotations a data.frame with columns "sound_id" (character), "region_id"
#' (character), "start" (numeric), "end" (numeric), "label" (character). The rows
#' represents the annotated regions of the audio.
#' @param color a character with the following format: 'rgb(r, g, b, a)'. Default is 'rgb(250, 200, 10, 0.5)'.
#'
#' @export
ws_add_regions <- function(id, annotations = NULL, color = NULL) {
  if(!missing(annotations) & !all(is.null(annotations$region_id))) {
    if(tidyr_new_interface()) {
      annotations <- tidyr::nest(annotations, attributes = c(sound_id, region_id, label))
    } else {
      annotations <- tidyr::nest(annotations, sound_id, region_id, label, .key = "attributes")
    }

    if(!is.null(color)) {
      annotations$color <- 'rgb(250, 200, 10, 0.5)';
    }
  }
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
#' @param new_volume numeric. The volume of the playback. 0 is mute, 1 is normal volume, 2 is twice loud and so on.
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
#' @param rate numeric. The speed of playback. 0.5 is half speed, 1 is normal speed, 2 is double speed and so on.
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
#' @param height numeric. The height of the visualization.
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
#' @param peaks numeric vector. Optional. the peaks to draw the soundwave.
#'
#' @export
ws_load <- function(id, url, peaks = NULL) {
  method <- "ws_load"
  callJS()
}

#' ws_seek_to
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @param progress numeric. Seeks to a progress [0..1] (0 = beginning, 1 = end).
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
#' @param progress numeric. Seeks to a progress and centers view. [0..1] (0 = beginning, 1 = end).
#'
#' @export
ws_seek_and_center <- function(id, progress) {
  method <- "ws_seek_and_center"
  callJS()
}

#' ws_minimap
#'
#' @param id wavesurfer object or a character of its respective element id.
#' @param waveColor a character. The color of the wave in hexadecimal representation. Default is '#999'.
#' @param progressColor a character. The color of wave behind the progress bar. In hexadecimal representation. Default is '#555'.
#' @param height a numeric. The height in pixels of the minimap.
#'
#' @export
ws_minimap <- function(id, waveColor = '#999', progressColor = '#555', height = 30) {
  method <- "ws_minimap"
  callJS()
}

#' ws_destroy_minimap
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_destroy_minimap <- function(id) {
  method <- "ws_destroy_minimap"
  callJS()
}

#' ws_regions
#'
#' @param id wavesurfer object or a character of its respective element id.
#' @param dragSelection a lofical. If TRUE lets you create regions by selecting areas
#' of the waveform with mouse. Useful for annotations. Default is TRUE.
#'
#' @export
ws_regions <- function(id, dragSelection = TRUE) {
  method <- "ws_regions"
  callJS()
}

#' ws_timeline
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_timeline <- function(id) {
  method <- "ws_timeline"
  callJS()
}

#' ws_destroy_timeline
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_destroy_timeline <- function(id) {
  method <- "ws_destroy_timeline"
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
#' @param fftSamples numeric. Number of FFT samples (512 by default). Number of spectral lines and height of the spectrogram will be a half of this parameter.
#' @param labels logical. Whether or not to display frequency labels on Y axis. Defaults to FALSE.
#' @param colorMap (not yet implemented) Specifies the colormap to be used when rendering the spectrogram.
#' @param height must be a valid CSS unit (like '100\%' or 'auto') or a number, which will be coerced to a string and have 'px' appended.
#'
#' @export
ws_spectrogram <- function(
  id,
  fftSamples = 512,
  labels = FALSE,
  colorMap = NULL,
  height = 128
) {
  if(is.numeric(height)) height <- paste0(height, "px")
  method <- "ws_spectrogram"
  callJS()
}

#' ws_destroy_spectrogram
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_destroy_spectrogram <- function(id) {
  method <- "ws_destroy_spectrogram"
  callJS()
}

#' ws_cursor
#'
#' @param id wavesurfer object or a character of its respective element id.
#' @param showTime a logical. If TRUE displays the time next to the cursor. Defaults to TRUE.
#' @param opacity a numeric. The opacity/transparency. Default is 1.
#' @param customShowTimeStyle a list with custom styles which are applied to the cursor time element, such
#' 'background-color', color, padding, 'font-size', etc.
#'
#' @export
ws_cursor <- function(id, showTime = TRUE, opacity = 1, customShowTimeStyle = list('background-color' = '#000', color = '#fff', padding = '2px', 'font-size' = '10px')) {
  method <- "ws_cursor"
  callJS()
}

#' ws_destroy_cursor
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_destroy_cursor <- function(id) {
  method <- "ws_destroy_cursor"
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
#' @param enable a logical. Default is TRUE.
#'
#' @export
ws_region_labeller <- function(id, enable = TRUE) {
  method <- "ws_region_labeller"
  callJS()
}

#' ws_annotator
#'
#' @param id wavesurfer object or a character of its respective element id.
#'
#' @export
ws_annotator <- function(id) {
  ws_region_labeller(ws_regions(id))
}
