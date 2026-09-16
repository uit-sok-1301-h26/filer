# JSON API spørring til SSB

# SOK-1301 Forelesning 8
# Bedrifter i Tromsø


rm(list=ls()) 

library(rjstat)
library(httr)
library(tidyverse)

url <- "https://data.ssb.no/api/pxwebapi/v2/tables/07091/data?lang=no&outputFormat=json-stat2&valuecodes[ContentsCode]=*&valuecodes[Tid]=*&valuecodes[Region]=F-55&codelist[Region]=agg_KommFylker&valuecodes[AntAnsatte]=99&valuecodes[NACE2007]=*&heading=ContentsCode,Tid&stub=Region,NACE2007,AntAnsatte"

df <- GET(url) %>%
  content(as = "text", encoding = "UTF-8") %>%
  fromJSONstat() %>%
  as_tibble()

# jeg vil slippe å skrive `` rundt "næring (SN2007)"
# R liker ikke tomrom, parentes osv i variabelnavn og ``
# forteller programmet å lese dette uansett
# norske bokstaver er vanligvis ikke problematisk

# filtrer for år 2026

df_2026 <- df %>% 
  filter(år == 2026) %>% 
  rename(næring = `næring (SN2007)`)

# hent ut tallet som viser totalt antall bedrifter

total_bedrifter <- df_2026 %>% 
  filter(næring == "Total") %>% 
  pull(value)

# regn ut prosent av totalt antall bedrifter

df_2026 <- df_2026 %>%
  filter(næring != "Total") %>%
  mutate(prosent = (value / total_bedrifter) * 100)

# lag plott

df_2026 %>% 
  ggplot(aes(x = næring, y = prosent)) +
  geom_col(fill = "green") +
  theme_minimal() +
  labs(title = "Andel av bedrifter etter næring, Tromsø kommune 2026",
       x = "Næring",
       y = "Prosent %") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

