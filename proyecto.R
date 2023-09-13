my_data <- read.csv2("friends.csv")

#view data
head(my_data)
tail(my_data)
View(my_data)

#Extract components of your dataframe
#[row, column]
my_data[1, 3]
my_data[, 3]
my_data$Eye.colour

install.packages("tidyverse")
library("tidyverse")
require("tidyverse")
#Start analysis
#%>% simboliza una canalizacion del codigo, 
#nos permite escribir una secuencia de operaciones de izquierda a derecha
my_data %>%
  select(Name, Age, Height) %>%
  filter(Age < 24 & Height > 1.78) %>%
  #Arrange es ordenar por
  arrange(Height)


