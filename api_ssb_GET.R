# SOK-1301 Forelesning 6
# Måling av ulikhet

# Ny API løsning til SSB
# Med GET

# Gå inn på Tabell 07756 SSB
# Velg verdier ved hjelp av "Filtrer" i venstre marg

# I venstre marg velger du deretter "Lagre", og skroll ned til API_spørring

# Velg format JSON-stat2 og GET

# Kopier URL og lim inn i koden nedenfor


rm(list = ls())

library(rjstat)
library(httr)
library(tidyverse)

url <- "https://data.ssb.no/api/pxwebapi/v2/tables/07756/data?lang=no&outputFormat=json-stat2&valuecodes[Tid]=*&valuecodes[ContentsCode]=*&valuecodes[Forbruksenhet2]=*&heading=Tid,Forbruksenhet2&stub=ContentsCode"

df <- GET(url) %>%
  content(as = "text", encoding = "UTF-8") %>%
  fromJSONstat() %>%
  as_tibble()
