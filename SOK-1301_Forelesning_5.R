# SOK-1301 Forelesning 5

# Sammenheng mellom lønnsvekst og arbeidsledighet i Norge, 1971-2024

# Data fra SSB, tabell 09786 og 08517

# rydd

rm(list=ls())

# last inn pakken
library(tidyverse)



# URL (csv fil)
url <- "https://raw.githubusercontent.com/uit-sok-1301-h26/uit-sok-1301-h26.github.io/refs/heads/main/data/lonn_arbled_f5.csv"

# last inn fila

df <- read.csv(url)

