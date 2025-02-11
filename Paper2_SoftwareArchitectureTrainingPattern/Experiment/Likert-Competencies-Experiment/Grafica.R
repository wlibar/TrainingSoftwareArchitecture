#Evalúe  en qué grado cree que el curso de arquitectura de software que acaba de proponer, ayuda a conseguir cada una de
#las siguientes competencias. En todas las preguntas se utilizará la siguiente escala:
#1. No ayuda
#2. Ayuda poco
#3. Neutral
#4. Ayuda
#5. Ayuda mucho

library(ggplot2)
library(dplyr)
library(sqldf)

#temp = '/media/libardo/datos/MiTesisDoctoral/Ciclo3-Validacion/GraficosR/Likert-Competencias/data-experimental.csv'
temp = '/media/libardo/datos/MiTesisDoctoral/Ciclo3-Validacion/GraficosR/Likert-Competencias/data-control.csv'

survey=read.csv(temp, stringsAsFactors = TRUE)

survey <- survey[,c("Question","Category","Responses")]

colnames(survey) <- c("question","category","responses")


#aggregating for all the responses into a df that contains only the question wise category wise total for all the students
agg_table <- sqldf::sqldf("select question, category, SUM(responses) as total from survey group by question, category")#question wise sum and percentage calculation for each category
summarized_table <- agg_table %>%
  group_by(question) %>%
  mutate(countT= sum(total)) %>%
  group_by(category, add=TRUE) %>%
  mutate(per=round(100*total/countT,2))#we have to reorder the factors to have a color palette that makes intuitive sensesummarized_table$category <- relevel(summarized_table$category,"N/A")
summarized_table$category <- relevel(summarized_table$category,"Does not help")
summarized_table$category <- relevel(summarized_table$category,"Little help")
summarized_table$category <- relevel(summarized_table$category,"Neutral")
summarized_table$category <- relevel(summarized_table$category,"Helps")
summarized_table$category <- relevel(summarized_table$category,"Helps a lot")



#define the colors on the scale
myColors <- c("darkgreen","green","yellow","orange","red")

ggplot(data = summarized_table, aes(x =question , y = per, fill = category))+
  geom_bar(stat="identity", width = 0.7)+
  scale_fill_manual (values=myColors)+
  coord_flip()+
  ylab("Percentage")+
  xlab("Question (competency)")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))+
  ggtitle("Evaluation of competencies of the control group")+
  theme(plot.title = element_text(size = 20, face = "bold",hjust = 0.5))
