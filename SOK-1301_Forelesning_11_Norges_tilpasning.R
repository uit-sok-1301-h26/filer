# SOK-1301 Forelesning 11

# Norges valg mellom fritid og konsum



# rydd

rm(list=ls())

# last inn pakken
library(tidyverse)

#lag aksen for tegningen

axes_1 <- ggplot()+
  labs(x=expression("Fritid"), y=expression("Konsum"))+
  theme(axis.title = element_text(size = 15),
        plot.title = element_text(size = 15),
        panel.background = element_blank(), # hvit bakgrunn
        axis.line = element_line(colour = "black"), # sett inn akselinjer
        axis.title.x = element_text(hjust = 1),
        axis.title.y = element_text(angle = 0, vjust = 1, hjust=1))+ # juster labels på aksene  
  scale_x_continuous(limits = c(15, 25), expand = c(0, 0))+
  scale_y_continuous(limits = c(0, 200), expand = c(0, 0)) # begrense aksene
# og sikre at akselinjene møttes i (0,0).

axes_1

# nyttefunkjsonen som brukes U=F^.783K^.15 (Cobb-Douglas)
# F=fritid, K=konsum

# vi angir noen indifferenskurver

I_0 <- function(F) (21.802^6.67)/F^(5.22) # nyttenivå 21.802
I_1 <- function(F) (20^6.67)/F^(5.22) # nytte=20


figur_1 <- axes_1 + labs(title="Norges tilpasning, 2021")+
  stat_function(
    fun=I_0,
    mapping = aes()
  ) +
  stat_function(
    fun=I_1,
    mapping = aes()
  ) +
  annotate("text",x=24,y=60, label=expression(u[0]))+
  annotate("text",x=24,y=40, label=expression(u[1]))

figur_1

# Du må angi budsjettlinjen

# Regn ut fra oppgitt info!

