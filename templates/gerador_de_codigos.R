# gerando os codigos via templates
library(glue)
library(dplyr)
library(magrittr)

html <- httr::GET("https://wavesurfer-js.org/api/class/src/wavesurfer.js~WaveSurfer.html") %>%
  httr::content() %>%
  rvest::html_table()

codigos <- tibble::tibble(
  method = html[[5]]$X2 %>%
    stringr::str_extract(".*\\(") %>% na.omit() %>%
    stringr::str_replace("\\(", ""),
  codigo_r = glue::glue(readChar("templates/method_template", 999)),
  codigo_js = glue::glue(readChar("templates/method_js_template", 999))
)

# public_methods R
codigos %>%
  dplyr::summarise(
    codigo = paste(codigo_r, collapse = "\n\n")
  ) %>%
  dplyr::pull() %>%
  cat

# public_methods JS
codigos %>%
  dplyr::summarise(
    codigo = paste(codigo_js, collapse = "\n\n")
  ) %>%
  dplyr::pull() %>%
  cat




# parametros do WaveSurfer.create

html <- httr::GET("https://wavesurfer-js.org/api/typedef/index.html#static-typedef-WavesurferParams") %>%
  httr::content() %>%
  rvest::html_table()
html[[14]] %>%
  set_names(.[1,]) %>%
  slice(-1) %>%
  mutate(
    attr_default = stringr::str_remove(Attribute, "default: "),
    attr_default = case_when(
      attr_default %in% "true" ~ "TRUE",
      attr_default %in% "false" ~ "FALSE",
      stringr::str_detect(attr_default, "'") ~ attr_default,
      stringr::str_detect(attr_default, "[0-9]") ~ attr_default,
      attr_default %in% c("null", "[]", "{}") ~ "NULL",
      TRUE ~ "NULL"
    ),
    attr_default = paste(Name, attr_default, sep = " = ")
  ) %>%
  dplyr::pull() %>%
  paste(collapse = ",\n") %>%
  cat
