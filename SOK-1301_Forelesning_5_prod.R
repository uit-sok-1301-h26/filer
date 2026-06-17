# SOK-1301 Forelesning 5

# Produksjon i Norge 

# Data fra SSB, tabell 09171
# Produksjon i basisverdi 1. kvartal 2026. Faste 2023-priser (mill. kr)
# Basisverdi er prisen selgeren mottar for varen, uten mva og avgifter med evt subsidier.


# rydd

rm(list=ls())

# last inn pakken
library(tidyverse)



# URL (csv fil)
url <- "https://raw.githubusercontent.com/uit-sok-1301-h26/uit-sok-1301-h26.github.io/refs/heads/main/data/prod_f5.csv"

# last inn fila


df <- read.csv(url, header = FALSE, sep=";")


# endre kolonnenavn

df <- df %>%
  rename(Næring = V1, Verdi = V2)

################
#  OPPGAVE    #
################

# 1 Bruk geom_bar() i ggplot 2 for å lage en stolpediagram av produksjonsverdier for hver næring
# 2 Er det lett å tolke denne visualiseringen? Hva kan gjøres for å forbedre den?

