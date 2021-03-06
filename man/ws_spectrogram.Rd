% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api.R
\name{ws_spectrogram}
\alias{ws_spectrogram}
\title{ws_spectrogram}
\usage{
ws_spectrogram(
  id,
  fftSamples = 512,
  labels = FALSE,
  colorMap = NULL,
  height = 128
)
}
\arguments{
\item{id}{wavesurfer object or a character of its respective element id.}

\item{fftSamples}{numeric. Number of FFT samples (512 by default). Number of spectral lines and height of the spectrogram will be a half of this parameter.}

\item{labels}{logical. Whether or not to display frequency labels on Y axis. Defaults to FALSE.}

\item{colorMap}{(not yet implemented) Specifies the colormap to be used when rendering the spectrogram.}

\item{height}{must be a valid CSS unit (like '100\%' or 'auto') or a number, which will be coerced to a string and have 'px' appended.}
}
\description{
ws_spectrogram
}
