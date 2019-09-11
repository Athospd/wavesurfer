
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wavesurfer

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/wavesurfer)](https://CRAN.R-project.org/package=wavesurfer)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

An interactive soundwave player and visualizer with rich set of plugins.
It works well with pipe (%\>%) and can be used in Shiny. It is an
interface of  JavaScript library and it is based on  R package.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("Athospd/wavesurfer")
```

## Examples

Usage at shiny app:

``` r
library(wavesurfer)
library(shiny)

ui <- fluidPage(
  wavesurferOutput("my_ws"),
  tags$p("Press spacebar to toggle play/pause."),
  actionButton("mute", "Mute", icon = icon("volume-off"))
)

server <- function(input, output, session) {
  output$my_ws <- renderWavesurfer({
    wavesurfer(audio = "http://ia902606.us.archive.org/35/items/shortpoetry_047_librivox/song_cjrg_teasdale_64kb.mp3") %>%
      ws_set_wave_color('#5511aa') %>%
      ws_spectrogram() %>%
      ws_cursor()
  })
  
  observeEvent(input$mute, {
    ws_toggle_mute("my_ws")
  })
}

shinyApp(ui = ui, server = server)
```

### Annotator

live app:

``` r
wavesurfer::runExample("annotator")
```

<img src="inst/img/annotator.gif">

### Plugins

live app:

``` r
wavesurfer::runExample("plugins")
```

<img src="inst/img/plugins.gif">

### Wave Decorations

live app:

``` r
wavesurfer::runExample("decoration")
```

<img src="inst/img/decoration.gif">

## Acknowledgement

The main actors that made this package possible were: -
[htmlwidgets](http://www.htmlwidgets.org/) package; - This
[tutorial](https://deanattali.com/blog/htmlwidgets-tips/) by [Dean
Attali](https://deanattali.com/) and his
[timevis](https://github.com/daattali/timevis) package from which I copy
pasted massively. - [wavesurfer.js](https://wavesurfer-js.org/) library
by [katspaugh](https://github.com/katspaugh).

Thank you.
