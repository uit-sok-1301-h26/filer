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



# filtrer for år 2026

df_2026 <- df %>% filter(år == 2026)

# hent ut tallet som viser totalt antall bedrifter

total_bedrifter <- df_2026 %>% 
  filter(`næring (SN2007)` == "Total") %>% 
  pull(value)

# regn ut prosent av totalt antall bedrifter

df_2026 <- df_2026 %>%
  filter(`næring (SN2007)` != "Total") %>%
  mutate(prosent = (value / total_bedrifter) * 100)

# lag plott

df_2026 %>% 
  ggplot(aes(x = `næring (SN2007)`, y = prosent)) +
  geom_bar(stat = "identity", fill = "green") +
  theme_minimal() +
  labs(title = "Andel av bedrifter etter næring, Tromsø kommune 2026",
       x = "Næring",
       y = "Prosent %") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

