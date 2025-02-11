#install.packages("tidyverse")
historial <- read.csv("./data.csv")
View(historial)
library(ggplot2)
library(dplyr) #para usar la funcion %>%
#en lugar de peso y nicotina = Minutes y Group

#Verificar que los datos siguen una distribucion normal y no tenga datos atipicos

ggplot(historial, aes(Minutes, fill=Group, color=Group))+
  geom_density(alpha=0.2)+
  xlim(100, 200)

#La grafica de densidad debe tener la famosa forma de campana de gauss

#Generamos un grafico qq donde se dibuja una linea y si los datos estan
#cerca a la recta, tienen una distribución normal

qqnorm(historial$Minutes)
qqline(historial$Minutes, col="red")

?qqnorm

#Shapiro-Wilk test dice con certeza si los datos tienen una distribución normal
#interesa el p-valor. si p-valor >0.05 no se rechaza la hipótesis nula. La 
#hipotesis nula dice que la muestra sigue una distribución normal. En otras
#palabras los Minutes siguen una distribución normal
shapiro.test(historial$Minutes)

#Ahora vamos a ver si hay datos atipicos en la muestra con un grafico de cajas
#No deben aparecer datos arriba de los limites superiores ni inferiores
#Ademas, se puede ver que el promedio para la GroupA es casi 6, y para la 
#GroupB es 7, por lo tanto, hay apreentemente una relación entre los Minutes y 
#el uso de las Groups


ggplot(historial, aes(Group, Minutes, fill=Group, color=Group ))+
  geom_boxplot(alph=0.4)+
  theme(legend.position = "none")


#Ahora, vamos a analizar los promedios de las muestras (Minutes)
historial %>%
  group_by(Group) %>%
  summarize (total = n(),
             Minutespromedio = mean(Minutes))

#Vemos que el promedio de una muestra es 5.8 y del segundo es 7.11, es decir,
#hay una diferencia significativa

#Vemos si las varianzas de los Groups son iguales
#Arroja un p-valor de 0.1805 que es mayor a 0.05, por lo tanto, no se rechaza
#la hipótesis nula, eso implica que las varianzas entre los dos Groups es la misma 

var.test(Minutes ~ Group, data=historial)

?var.test
#Finalmente hacemos la prueba de t-studente para reforzar lo que hemos visto
#gráficamente

#Prueba t, analiza la variable Minutes, diferenciándola del tipo de Group usado
#asumiendo que las dos varianzas son iguales

t.test(Minutes ~ Group, data=historial, var.equal = T)

#La prueba t arroja un p-valor de 0.001702 asociado a un t=-3.3912, el cual es
#menor a 0.05, por lo tanto rechazamos al hipótesis nula. La hipotesis nula
#dice que la diferencia entre los promedios de las muestras es cero. Por lo
#tanto llegamos a la conclusion que las muestras son distintas (aceptamos la hipotesis alternativa)


