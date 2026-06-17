# JSON API spørring til SSB

# SOK-1301 Forelesning 9
# Utvikling i reallønn og produktivitet


rm(list=ls()) 

library(rjstat)
library(httr)
library(tidyverse)

# last inn "Bruttoprodukt per utførte timeverk. Endring fra året før (prosent). Faste priser"
# fra tabell 09174 SSB

url <- "https://data.ssb.no/api/pxwebapi/v2/tables/09174/data?lang=no&outputFormat=json-stat2&valuecodes[Tid]=*&valuecodes[NACE]=nr23_6&codelist[NACE]=vs_NRNaeringPubAgg&valuecodes[ContentsCode]=BruttoprodTimev&heading=Tid,ContentsCode&stub=NACE"

df_prod <- GET(url) %>%
  content(as = "text", encoding = "UTF-8") %>%
  fromJSONstat() %>%
  as_tibble()


# last inn "Reallønn. Årslønn, påløpt i 2010-priser. Indeks (2010=100)"
# fra tabell 09786 SSB

url2 <- "https://data.ssb.no/api/pxwebapi/v2/tables/09786/data?lang=no&outputFormat=json-stat2&valuecodes[ContentsCode]=RealArslonnIndeks&valuecodes[Tid]=*&heading=Tid&stub=ContentsCode"

df_wage <- GET(url2) %>%
  content(as = "text", encoding = "UTF-8") %>%
  fromJSONstat() %>%
  as_tibble()



# følgende kode fra ChatGPT lager df_prod om til en indeks med 2010=100

# 1970 er NA så vi fjerner den

df_prod <- df_prod %>% 
  filter(år != "1970")


# Sortér data etter år, og lag en indeks-kolonne
# Vi setter startverdien for indeksen i 1971 lik 100 (basisår = 1971).
df_prod <- df_prod %>%
  arrange(år) %>%
  mutate(index = ifelse(år == 1971, 100, NA))

# Funksjon som beregner indeks fra årlige prosentvise endringer ('value')
# Antakelse: 'value' er årlig vekstrate i prosent (f.eks. 2.5 = 2,5 %).
# Logikk:
# - Start med initial_index (100).
# - For hvert påfølgende år: multipliser med (1 + vekstrate_i/100).
# - cumprod() gir løpende (kumulerte) produkt → kjedeindeks.
calculate_index <- function(value, initial_index) {
  cumprod(c(initial_index, 1 + value[-1] / 100))
}

# Beregn indeksen for hele serien med 1971 = 100
# NB: For at calculate_index skal stemme, må 'value' være sortert på år
#     og ha samme lengde som df_prod. Første års verdi tolkes som
#     "startpunkt" (vi har allerede 100), derfor value[-1].
df_prod <- df_prod %>%
  mutate(index = calculate_index(value, 100))

# --- Rebasering av indeks ---

# Noen ganger vil vi sette et annet basisår (f.eks. 2010 = 100)
# Prinsipp: del alle indeksverdier på nivået i basisåret og gang med 100.
rebase_index <- function(data, base_year) {
  base_value <- data %>% filter(år == base_year) %>% pull(index)
  # Hvis base_year mangler, vil base_value bli NA → gir NA-resultat.
  # Sjekk derfor at base_year finnes i data før bruk.
  data %>%
    mutate(index = (index / base_value) * 100)
}

# Rebasér slik at 2010 = 100
df_prod_rebased <- rebase_index(df_prod, 2010)


# nå kan vi kombinere begge dataframes

# ta bort 1970 og kolonne "value" fra df_wage


df_wage <- df_wage %>% 
  filter(år != "1970") %>% 
  rename(index = value)

# ta bort kolonne "value" fra df_prod_rebased

df_prod_rebased <- df_prod_rebased %>% 
  select(-value)

df <- bind_rows(df_wage, df_prod_rebased) %>%
  arrange(år, statistikkvariabel)

# gi nye navn til statistikkvariablene

unique_names <- unique(df$statistikkvariabel)

df <- df %>%
  mutate(statistikkvariabel = ifelse(statistikkvariabel == unique_names[1], "Bruttoprodukt per timeverk", "Reallønn"))



# OPPGAVE: Bruk df og lag en figur som viser utviklingen av reallønn og bruttoprodukt over tid



