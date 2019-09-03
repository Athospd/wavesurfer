library(shiny)
library(wavesurfer)

pasta_wavs <- "/media/athos/DATA/OneDrive/Documents/mestrado/data-raw/wav_12khz/"
shiny::addResourcePath("wavs", pasta_wavs)
pasta_anotacoes <- "/media/athos/DATA/OneDrive/Documents/mestrado/data/anotacoes/"

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Anotador"),

    uiOutput("especies"),
    uiOutput("arquivo_wav"),

    actionButton("minimap", "Minimap", icon = icon("map")),
    actionButton("spectrogram", "spectrogram", icon = icon("chart")),
    actionButton("microphone", "Microphone", icon = icon("mic")),
    actionButton("regions", "Regions", icon = icon("square")),
    actionButton("cursor", "Cursor", icon = icon("pointer")),
    actionButton("elan", "Elan", icon = icon("chat")),
    actionButton("timeline", "Timeline", icon = icon("time")),
    tags$br(),

    wavesurferOutput("meu_ws", height = "100%"),
    actionButton("play", "Play", icon = icon("play")),
    actionButton("pause", "Pause", icon = icon("pause")),
    actionButton("mute", "Mute", icon = icon("times")),
    actionButton("stop", "Stop", icon = icon("stop")),
    actionButton("save", "Save", icon = icon("save")),
    actionButton("sugerir_regioes", "Sugerir regiões", icon = icon("cut")),
    tags$br(),
    sliderInput("zoom", "Zoom", min = 1, max = 1000, value = 50),
    tags$br(),
    verbatimTextOutput("regions"),
    verbatimTextOutput("current_region"),
    verbatimTextOutput("regions_class")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    passaros <- readr::read_rds("/media/athos/DATA/OneDrive/Documents/mestrado/data/passaros.rds")
    wav_name <- reactive({stringr::str_replace(input$audio, "^wavs/", "")})
    output$especies <- renderUI({
        selectizeInput(
            "especie",
            "Espécie: ",
            choices = passaros$especie,
            width = "100%"
        )
    })

    output$arquivo_wav <- renderUI({
        req(!is.null(input$especie))

        audios_nao_anotados <- paste0("wavs/", list.files(pasta_wavs, pattern = input$especie))
        audios_anotados <- paste0("wavs/", stringr::str_replace(list.files(paste0(pasta_anotacoes)), "rds$", "wav"))
        audios_nao_anotados <- audios_nao_anotados[!audios_nao_anotados %in% audios_anotados]

        selectizeInput(
            "audio",
            "Audio: ",
            choices = audios_nao_anotados,
            width = "100%"
        )
    })

    output$meu_ws <- renderWavesurfer({
        req(!is.null(input$audio))
        annotations_path <- stringr::str_replace_all(stringr::str_replace_all(input$audio, "wav$", "rds"), "^wavs/", "")
        annotations_path <- paste0(pasta_anotacoes, annotations_path)

        if(file.exists(annotations_path)) {
            annotations_df <- readr::read_rds(annotations_path) %>% dplyr::mutate(label = character(0))
        } else {
            annotations_df <- NULL
        }
        annotations_df <- data.frame(
            start = 3,
            end = 4,
            label = "teste"
        )
        wavesurfer(
            input$audio,
            barWidth = 2
        ) %>%
            ws_set_wave_color(color = "#aa88ff")
    })

    observeEvent(input$play, {
        ws_play("meu_ws")
    })

    observeEvent(input$pause, {
        ws_pause("meu_ws")
    })

    observeEvent(input$mute, {
        ws_toggle_mute("meu_ws")
    })

    observe({
        ws_zoom("meu_ws", input$zoom)
    })

    observeEvent(input$stop, {
        ws_stop("meu_ws")
    })

    observeEvent(input$minimap, {
        ws_minimap("meu_ws")
    })

    observeEvent(input$spectrogram, {
        ws_spectrogram("meu_ws")
    })

    observeEvent(input$timeline, {
        ws_timeline("meu_ws")
    })

    observeEvent(input$cursor, {
        ws_cursor("meu_ws")
    })

    observeEvent(input$elan, {
        ws_elan("meu_ws")
    })

    observeEvent(input$regions, {
        ws_regions("meu_ws")
    })

    observeEvent(input$microphone, {
        ws_minimap("meu_ws")
    })


    observeEvent(input$save, {
        req(!is.null(wav_name()))
        annotations <- stringr::str_replace_all(stringr::str_replace_all(input$audio, "wav$", "rds"), "^wavs/", "")
        regions <- input$meu_ws_regions %>% dplyr::mutate(sound_id = wav_name())
        readr::write_rds(x = regions, path = paste0(pasta_anotacoes, annotations))
    })

    observeEvent(input$sugerir_regioes, {

        wav <- tuneR::readWave(paste0(pasta_wavs, wav_name()))

        ## funcao do auto detector
        auto_detect_partial <- purrr::partial(
            warbleR::auto_detec,
            X = data.frame(sound.files = wav_name(), selec = 1, start = 0, end = Inf),
            path = pasta_wavs,
            pb = FALSE
        )
        params_do_auto_detec <- passaros$parametros_do_auto_detect[[input$especie]]
        ## segmentacoes encontradas
        suggested_annotations <- do.call(auto_detect_partial, params_do_auto_detec)
        suggested_annotations$sound.files <- wav_name()
        if(is.null(suggested_annotations$label)) {
            suggested_annotations$label <- "(unlabeled)"
        }
        suggested_annotations <- suggested_annotations %>% dplyr::mutate(label = sample(letters, size = length(label), replace = TRUE))
        names(suggested_annotations) <- c("sound_id", "segmentation_id", "start", "end", "label")
        ws_add_regions("meu_ws", suggested_annotations)
    })

    output$regions_class <- renderPrint({
        reactiveValuesToList(input)
    })

    output$current_region <- renderPrint({
        input$meu_ws_selected_region
    })
    output$regions <- renderPrint({
        input$meu_ws_regions
    })
}

# Run the application
shinyApp(ui = ui, server = server)



