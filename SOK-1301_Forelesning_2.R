
# SOK-1301 Kode til Forelesning 2



# slett minne, last inn tidyverse og Ecdat

rm(list=ls())

library(tidyverse)
library(Ecdat)


# henter ferdiglagret data
data(Wages)

# forklaring: https://rdrr.io/cran/Ecdat/man/Wages.html
# NB! Les denne.

# se på data 
Wages

# dette er lite oversiktlig

# vi lagrer dataene som en tibble, se kapittel 3 i pensum

Wages <- as_tibble(Wages)

Wages

# dette er mye mer oversiktlig!

# se på type objekt i hver kolonne (str for structure/struktur)
str(Wages)


# Int er integer (heltall), num er numeric, 
# Factor er en faktor 
# (en datatype som brukes til å representere kategoriske data som deles inn i kategorier uten en naturlig orden, 
# for eksempel kjønn (mann, kvinne)).

# Vi bruker "piping" fra tidyverse for å gjøre koden lettere å arbeide med. 
# Pipesymbolet er %>% : Ctrl + Shift + M i Windows, Cmd + Shift + M på Mac.



# først et enkelt eksempel:
select(Wages,lwage)

# forklar kommandoen. hva skjedde?

# prøv denne:
Wages %>%
  select(lwage)

# hva skjedde?

# piping lar oss dele opp koden, og utføre én kommando av gangen.
# symbolet %>% betyr: bruk dette som første argument i neste kommando.
# x %>% f(y) er det samme som f(x,y)!

# Hvorfor bruke piping?
# Jo, det er lettere å lese vertikalt enn horisontalt!


# I dette datasettet har vi en variabel som heter lwage  som er logaritmen til lønna. 
# For å finne lønna i USD må vi "nøytralisere" logaritmen med exp (dere vil lære om dette i BED-1007).

# Legg til en kolonne med faktisk lønn (ikke log)
Wages <- Wages %>%
  mutate(wage = exp(lwage))

# Forklar hva som skjedde her!


# Det ser ut som om wage gir oss lønn pr. uke målt i USD.

# La oss gi nye navn til noen variabler

rename(Wages, utdanning = ed)
rename(Wages, ukeslønn = wage)

# Se i konsollen, og forklar hva som skjedde nå.

#############################################################
### SPØRSMÅL 1: Kan du lage denne kommandoen med en pipe? ###
#############################################################

# ditt svar her




#####################################################################
### SPØRSMÅL 2: Kan du skrive om kommandoen så endringene lagres? ###
#####################################################################

# ditt svar her

# la oss prøve å lage en graf, med piping

Wages %>%
  
  ggplot(aes(x=utdanning,y=ukeslønn)) +
  
  geom_point() +
  
  theme_minimal()

# I tidyverse er det mest vanlig å bruke %>% kun frem til ggplot(), og deretter bygge opp plottet med +

#######################################################################
### SPØRSMÅL 3: Hva er det du ser? Forklar så konkret som mulig. ###
#######################################################################

# ditt svar her

# se på denne grafen

Wages %>%
  
  ggplot(aes(x = utdanning, y = ukeslønn), color = sex)) +
  
  geom_point() +
  
  theme_minimal()



# det fungerte ikke.


#####################################################
### SPØRSMÅL 4: Kan du fikse koden så den kjører? ###
#####################################################

# ditt svar her

# se på denne grafen
# se du hva som er annerledes?

Wages %>%
  
  ggplot(aes(x = utdanning, y = ukeslønn, color = sex)) +
  
  geom_point() +
  
  theme_minimal()


#####################################################
## SPØRSMÅL 5: Lag en ny figur med lwage på y-aksen##
#####################################################

# ditt svar her


# Ser du noen fordeler med å bruke logaritmen til lønna?

Wages %>%
  
  ggplot(aes(x = utdanning, y = lwage, color = sex)) +
  
  geom_point() +
  
  theme_minimal()

# La oss gjøre noen beregninger

Wages <- Wages %>%
  mutate(av_lønn = mean(ukeslønn))


################################################
### SPØRSMÅL 6: Hva gjorde denne kommandoen? ###
################################################

# ditt svar her

# La oss beregne prosentvis avvik fra av_lønn

Wages <- Wages %>%
  mutate(pc_avvik = 100(ukeslønn - av_lønn)/av_lønn)


#####################################################
### SPØRSMÅL 7: Kan du fikse koden så den kjører? ###
#####################################################

# ditt svar her

# se til slutt på denne grafen

Wages %>%
  
  ggplot(aes(x = utdanning, y = pc_avvik, color = sex)) +
  
  geom_point() +
  
  theme_minimal()

###########################################################################
### SPØRSMÅL 8: Forklar figuren som vi har laget.                       ###
###########################################################################

# ditt svar her