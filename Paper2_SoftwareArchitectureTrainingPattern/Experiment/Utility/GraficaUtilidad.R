#UTILIDAD PERCIBIDA

#¿Cuál es el nivel de utilidad de la guía en tu trabajo como docente de 
#arquitectura de software

#install.packages("tidyverse")

historial <- read.csv("./data.csv",sep="\t")
View(historial)
library(ggplot2)
library(dplyr) #para usar la funcion %>%


ggplot(historial, aes(Group, Satisfaction_level, fill=Group, color=Group ))+
  geom_boxplot(alph=0.4)+
  theme(legend.position = "none")+
  labs(y="Satisfaction level", x="Groups")

#Ahora, vamos a analizar los promedios de las muestras 
historial %>%
  group_by(Group) %>%
  summarize (total = n(),
             satisfaccion_promedio = mean(Satisfaction_level))