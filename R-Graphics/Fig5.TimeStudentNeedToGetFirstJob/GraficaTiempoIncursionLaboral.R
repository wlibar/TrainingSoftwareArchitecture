library(readxl)
library(ggplot2)
ruta_excel <- "/home/libardo/Escritorio/PruebasRGraficas/Manera1/datos.xlsx"


datos <-read_excel(ruta_excel)


p <- ggplot(data = datos,
            mapping = aes(x = factor(Time),
                          fill = factor(Course))) +
  xlab("Semesters lapsed to get my first job in the software industry, O: 'I still can't get my first job'")
  

p + geom_bar(position = 'stack', stat = 'count')

# dogde bar chart
p + geom_bar(position = 'dodge', stat = 'count')

# stacked + percent barchart
p + geom_bar(position = 'fill', stat = 'count')
