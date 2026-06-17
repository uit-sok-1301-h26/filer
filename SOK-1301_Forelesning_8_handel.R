# JSON API spørring til SSB

# SOK-1301 Forelesning 8
# Internasjonal handel

# Hent data fra SSBs tabell 10482

rm(list=ls()) 

library(rjstat)
library(httr)
library(tidyverse)

url <- "https://data.ssb.no/api/pxwebapi/v2/tables/10482/data?lang=no&outputFormat=json-stat2&valuecodes[ContentsCode]=*&valuecodes[Tid]=2025&valuecodes[Region]=*&valuecodes[SITC]=*&heading=ContentsCode,Tid,SITC&stub=Region"

df <- GET(url) %>%
  content(as = "text", encoding = "UTF-8") %>%
  fromJSONstat() %>%
  as_tibble()

# her er det mange 0 verdier pga at fylket ikke eksisterer i 2025
# vi fjerner disse

df <- df %>% 
  filter(value != 0)


# vi velger ut kun noen fylker

utvalgte_regioner <- c(
  "Oslo",
  "Viken",
  "Innlandet",
  "Vestfold og Telemark",
  "Agder",
  "Rogaland",
  "Vestland",
  "Møre og Romsdal",
  "Trøndelag - Trööndelage",
  "Nordland - Nordlánnda",
  "Troms - Romsa - Tromssa"
)

df_utvalgt <- df %>% 
  filter(region %in% utvalgte_regioner)



# OPPGAVE 1. Bruk df_utvalgt og lag en stolpediagram som viser "Varer i alt" for hvert fylke

## Svar her



# OPPGAVE 2. Nå skal du plotte alle varegruppene for hvert fylke. 
# Vi tar først bort "Forskjellige ferdigvarer" og "Varer i alt"

df_utvalgt_ny <- df_utvalgt %>% 
  filter(varegruppe != "Forskjellige ferdigvarer", varegruppe != "Varer i alt")

# HINT: vi bruker facet_wrap(~ varegruppe) for å få en graf per varegruppe

## Svar her

# Vi ser at det er en varegruppe som heter "¬ Fisk" som er en undergruppe av "Matvarer, drikkevarer, tobakk"
# Vi kan endre navnet på denne varegruppen til "Matvarer, drikkevarer, tobakk (Fisk)"

df_endelig <- df_utvalgt_ny %>% 
  mutate(varegruppe = ifelse(varegruppe == "¬ Fisk", "Matvarer, drikkevarer, tobakk (Fisk)", varegruppe))

# OPPGAVE 3. Tegn samme figur som i oppgave 2 ved å bruke df_endelig.
# Denne gangen skal du bruke facet_wrap(~ varegruppe, scales = "free_y")
# Hva skjer?

## Svar her
