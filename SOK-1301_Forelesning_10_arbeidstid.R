# SOK-1301 Forelesning 10

# Arbeidstid


rm(list=ls()) 


library(tidyverse)
library(eurostat) 



df <- get_eurostat("tps00071")  %>% 
  label_eurostat() 



# OPPGAVE 1: Lag en liggende stolpediagram av gjennomsnittlig arbeidstid per uke i 2025 for hvert land



# OPPGAVE 2: Vis utviklingen over tid i gjennomsnittlig arbeidstid i Norge

