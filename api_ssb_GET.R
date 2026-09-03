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

# Dersom du skal bruke dette til å laste ned data fra flere tabeller,
# kan det være lurt å lage seg en funksjon

# Hjelpefunksjon: samme GET-oppskrift som ovenfor
hent_ssb <- function(url) {
  GET(url) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSONstat() %>%
    as_tibble()
}

# Bruk: df <- hent_ssb(url)

url2 <- paste0(
  "https://data.ssb.no/api/pxwebapi/v2/tables/09842/data",
  "?lang=no",
  "&outputFormat=json-stat2",
  "&valuecodes[ContentsCode]=BNP,MEMOBNP",
  "&valuecodes[Tid]=*",
  "&heading=Tid",
  "&stub=ContentsCode"
)

df_bnp <- hent_ssb(url2)
