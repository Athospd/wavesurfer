
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wavesurfer

<img src = 'inst/img/ggwave.png'>

An interactive soundwave player and visualizer with rich set of plugins.
It works well with pipe (%\>%) and can be used in Shiny. It is an
interface of [‘wavesurfer.js’](https://wavesurfer-js.org) JavaScript
library and it is based on [‘htmlwidgets’](http://www.htmlwidgets.org/)
R package.

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
[athos.shinyapps.io/wavesurfer\_annotator/](https://athos.shinyapps.io/wavesurfer_annotator/)

``` r
wavesurfer::runExample("annotator")
```

<img src="inst/img/annotator.gif">

### Plugins

live app:
[athos.shinyapps.io/wavesurfer\_plugins/](https://athos.shinyapps.io/wavesurfer_plugins/)

``` r
wavesurfer::runExample("plugins")
```

<img src="inst/img/plugins.gif">

### Wave Decorations

live app:
[athos.shinyapps.io/wavesurfer\_decoration/](https://athos.shinyapps.io/wavesurfer_decoration/)

``` r
wavesurfer::runExample("decoration")
```

<img src="inst/img/decoration.gif">

## Acknowledgement

The main actors that made this package possible were:

  - [htmlwidgets](http://www.htmlwidgets.org/) package;
  - [This tutorial](https://deanattali.com/blog/htmlwidgets-tips/) by
    [Dean Attali](https://deanattali.com/) and his
    [timevis](https://github.com/daattali/timevis) package from which I
    copy pasted massively.
  - [wavesurfer.js](https://wavesurfer-js.org/) library by
    [katspaugh](https://github.com/katspaugh).
  - [This annotator](https://github.com/CrowdCurio/audio-annotator) that
    inspired me for make the spectrogram visualization for wavesurfer.js
    3.0.0. A lot of ctr+C/ctr+V too.
  - [wikiaves.com.br](https://wikiaves.com.br) from where I took audio
    examples for the showcases.

Thank you very much for your work.