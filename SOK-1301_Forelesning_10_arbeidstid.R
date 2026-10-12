# SOK-1301 Forelesning 10

# Arbeidstid


rm(list=ls()) 


library(tidyverse)
library(eurostat) 



df <- get_eurostat("tps00071")  %>% 
  label_eurostat() 



# OPPGAVE 1: Lag en liggende stolpediagram av gjennomsnittlig arbeidstid per uke i 2025 for hvert land
# Vi farger også Norge-stolpen rød.
# Bruker scale_fill_manual for å spesifisere fargene på stolpene

# Filtrer til 2025, merk Norge for egen farge, og lag liggende, sortert stolpediagram


# OPPGAVE 2: Vis utviklingen over tid i gjennomsnittlig arbeidstid i Norge

