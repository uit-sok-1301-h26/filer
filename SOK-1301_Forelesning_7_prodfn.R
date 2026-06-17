# SOK-1301 Forelesning 7

#Plott en enkel produktfunksjon

rm(list = ls())

library(tidyverse)


#lag aksen for tegningen

axes_1 <- ggplot()+
  labs(x="x", y="y") +
  theme(axis.title = element_text(size = 15),
        plot.title = element_text(size = 15),
        panel.background = element_blank(), # hvit bakgrunn
        axis.line = element_line(colour = "black"), # sett inn akselinjer
        axis.title.x = element_text(hjust = 1),
        axis.title.y = element_text(angle = 0, vjust = 1)) + # juster labels på aksene  
  coord_fixed(ratio = 1)+ # lik skala for x og y aksen
  scale_x_continuous(limits = c(0, 20), expand = c(0, 0))+
  scale_y_continuous(limits = c(0, 20), expand = c(0, 0)) # begrense aksene
# og sikre at akselinjene møttes i (0,0).

axes_1

# Pruduktfunksjonen tar form y = Z*x^a (Cobb-Douglas)
# (eksempel) y=2*x^.5



y_0 <- function(x) (2*x^.5) 

figur_1 <- axes_1 + labs(title="Produktfunksjon")+
  stat_function(
    fun=y_0
  )+
  annotate("text",x=19,y=10, label=expression(y[0]))

figur_1

# øk Z til 4

y_1 <- function(x) (4*x^.5)

figur_2 <- figur_1 + 
  stat_function(
    fun=y_1,
    color="red"
    )+
  annotate("text",x=19,y=19, label=expression(y[1]))

figur_2

# øk a til 0.75

y_2 <- function(x) (4*x^.75)

figur_3 <- figur_2 + 
  stat_function(
    fun=y_2,
    color="blue"
    )+
  annotate("text",x=7,y=19, label=expression(y[2]))

figur_3


