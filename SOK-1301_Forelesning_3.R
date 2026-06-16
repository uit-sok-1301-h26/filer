# SOK-1301 Kode til Forelesning 3

############################
### R-kode forelesning 3 ###
### Skrevet av:          ###
### Derek J. Clark,      ###
### Mikko Moilanen og    ###
### Even S. Hvinden      ###
### Tidligere UiT        ###
### Nå: Forsvarets       ### 
### forskningsinstitutt  ###
############################

# rydd opp
rm(list=ls())

# last inn tidyverse
library(tidyverse)

############################
### data i tibble-format ### 
############################


# les CO2 data i .csv-format fra OWID
co2data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# se: https://github.com/owid/co2-data
# se en beskrivelse av data her: https://github.com/owid/co2-data/blob/master/owid-co2-codebook.csv

# se på dataene i konsollen
co2data

###########################
### kommandoen select() ### 
###########################

select(co2data,year)

# beskriv hva kommandoen gjør

###########################################################
### Oppgave 1: Kan du skrive om kommandoen med en pipe? ### 
###########################################################



###########################
### kommandoen filter() ### 
###########################

filter(co2data,iso_code == "SWE")


# beskriv hva kommandoen gjør


co2data <- co2data %>%
  filter(!is.na(iso_code))

# beskriv hva denne kommandoen gjør



# Bonus: sjekk hvor mange ulike land/territorier vi har nå i datasettet
n_distinct(co2data$iso_code)

#############################################################################
### Oppgave 2A: Kan du lage en tabell som viser verdiene for Norge mellom ###
### årene 2021 og 2023? Bruk en pipe!                                     ###
### Hint: between(year, 2021, 2023) er det samme som å si at year ligger  ###
### mellom 2021 og 2023                                                   ###
#############################################################################


# skriv din kode her


# svar hvorfor følgende ikke fungerer:

co2data %>% 
  filter(iso_code=="NOR" & year==2018:2020)


# Bonus: denne lager en figur med  Norge
co2data %>%
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2)) +
  + geom_line() 
  + theme_minimal()

################################################################################
### Oppgave 2B.Lag en tabell for Norge som kun viser hvert femte år mellom   ###
### 2000 og 2020 . Bruk c() til å lage listen.                               ###
### Hint: c(2000, 2005, 2010, 2015, 2020) lager en kort liste med de årene   ###
### du vil ha.Bruk så year %in% <den listen> i filter().                     ###
################################################################################
######################
### Kommandoen c() ###
######################
# c() er kort for "concatenate" -- et fancy begrep for å koble sammen
# nyttig for å lage lister
liste <- c("Ola", "Geir")
liste


# Skriv ditt svar her
### Tips: Bruk filter(var %in% c("verdi1", "verdi2))





### klarer du også å lage en figur med disse årene?####




##########################################################################
### Oppgave 3: Kan du lage en figur med CO2 utslipp for Norge og Kina? ###
##########################################################################

### Tips: Bruk filter(var %in% c("verdi1", "verdi2))
### Tips: Bruk color = country i aes()



# kommenter figuren. gir den en god sammenligning?

#############################################################################
### Oppgave 4: Kan du lage en figur fra 1990 med CO2 utslipp pr. person for Norge, ###
### Kina, Frankrike, USA og Saudi Arabia?                                 ###
#############################################################################

countries <- c("Norway", "China", "France", "United States", "Saudi Arabia")



# beskriv figuren. hva er det vi ser? hva legger du merke til? 
# hva tror du ligger bak forskjellene? 

############################
### kommandoen arrange() ### 
############################

# vi bruker arrange() til å lage en ordnet tabell

# eksempel fra forelesningen
arrange(co2data, co2)

# prøv med flere variabler

df <- co2data %>%
  arrange(gdp,methane,co2)

# skriver den ut i konsollen. 
df

# Eksempel utenom datasettet

df1 <- tibble(x = c(3, 3, 4, 2), y = c("B", "A", "D", "C"))

df1

arranged_df1_x <- df1 %>% arrange(x)

arranged_df1_x

arranged_df2_x <- df1 %>% arrange(desc(x))

arranged_df2_x                                  

arranged_df1_y <- df1 %>% arrange(y)

arranged_df1_y

arranged_df1_x_y <- df1 %>% arrange(x,y)

arranged_df1_x_y

##########################################################################
### Oppgave 5: Beskriv hvordan co2data var arrangert i utgangspunktet. ###
### Kan du bruke arrange() til å transformere df tilbake og lagre?     ###
##########################################################################



###########################
### kommandoen mutate() ### 
###########################

# Variabelen co2 viser utslipp i millioner tonn. For å få den i tonn:

co2data %>%
  mutate(co2_tonn=1e6*co2) %>% 
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2_tonn)) %>%
  + geom_line() %>%
  + theme_minimal()


#################################################################################################################################################################
### Oppgave 6: Variabelen consumption_co2_per_capita måler utslipp knyttet                                                                                    ###
### til konsum. Bruk mutate() til å lage en variabel som viser utslipp per                                                                                    ###
### capita utenom konsum. Gjenskap figuren med Norge, USA, Kina, Frankrike                                                                                    ###
### og Saudi Arabia.                                                                                                                                          ###
### Hvis differansen er positiv → landet er en nettoeksportør av karbonutslipp (slipper ut mer hjemme enn som trengs til eget konsum).                        ###
### Hvis differansen er negativ → landet er en nettoimportør av karbonutslipp (forbruket gir opphav til mer utslipp i andre land enn det man produserer selv).###
### Kommenter. Ble du overrasket?                                                                                                                             ###
### Hint: du trenger!is.na() for å fjerne manglende observasjoner                                                                                             ###
#################################################################################################################################################################

countries <- c("Norway", "China", "France", "United States", "Saudi Arabia")


# beskriv figuren. hva er det vi ser? hva legger du merke til?




##############################
### kommandoen summarise() ### 
##############################

# n() gir antall observasjoner
co2data %>%
  group_by(year) %>% 
  summarise(sum = sum(co2), n=n())

###################################################################
### Oppgave 7: Lag en figur med totale globale utslipp over tid ### 
###################################################################




##########################################################################
### Oppgave 8: Lag en vakker graf. Legg til ny farge, tittel, lag egne ###
### benevninger på aksene, skalering, tykkere linjer. Prøv deg frem!   ### 
##########################################################################

# sjekk for eksempel her: https://r-charts.com/ggplot2/
# eller her: https://ggplot2.tidyverse.org/reference/ggtheme.html
# tips: bruk xlab(), ylab(), ggtitle()...