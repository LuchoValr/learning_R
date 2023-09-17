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

#descargar paquetes
#install.packages("tidyverse")
#Library y require ambas pueden ser usadas para leer paquetes
library("tidyverse")
require("tidyverse")
#Start analysis
#%>% simboliza una canalizacion del codigo, 
#nos permite escribir una secuencia de operaciones de izquierda a derecha
#Es como poner un codigo y luego decir "y luego"
my_data %>%
  select(Name, Age, Height) %>%
  filter(Age < 24 & Height > 1.78) %>%
  #Arrange es ordenar por
  arrange(Height)

#Al importar datos de excel, tendremos multiples opciones
#como seleccionar el tipo de dato de las variables
#darle nombre a la base
#la hoja de calculo que usamos si estamos usando un archivo excel
#El rango de datos con los archivos excel tambien
#Maximo de filas
#Saltar filas, como las que estan decoradas
#Especificar como estan denotados los datos faltantes
#Lo primero a tener en cuenta es no importar de forma facil
#Sino copiar el codigo de la importacion de los datos a nuestro script
#En nuestro proyecto, podremos darle click derecho directamente a nuestra
#carpeta del proyecto e importar
?read_excel


##Manipular datos

require(tidyverse)
#Hay datasets que podemos usar en tidyverse, para verlos solo ejecutamos data()
data()
View(starwars)

str <- starwars %>%
  select(gender, mass, height, species) %>%
  filter(species == "Human") %>%
  na.omit() %>% 
  mutate(height = height/100) %>%
  mutate(BMI = mass/height^2) %>%
  group_by(gender) %>%
  summarise(Average_BMI = mean(BMI))
print(str)

##Entrando en variables
my_data2 <- read.csv2("learning_R/friends.csv")
#informacion de el tipo de variable y lo que contiene
str(my_data2)
my_data2$Eye.colour <- as.factor(my_data2$Eye.colour)
my_data2$Eye.colour <- as.numeric(my_data2$Eye.colour)
#Podemos asignar la variable categorica si tiene un orden, PARA ACLARAR aqui use la del color de ojos por el ejemplo
#Aqui podemos hacer una dummy pero queda con valores de 1 y 2
my_data2$Sex <- as.factor(my_data2$Sex)
my_data2$Sex <- as.numeric(my_data2$Sex)
?as.factor
#as.factor() es usado para variables categoricas
#as.numeric() para variables continuas
#as.integer() enteros

#Ejemplo
#c() se refiere a un grupo, como una lista casi
levels(my_data2$Eye.colour)
#para ver las categorias de una variable, despues de asignar realizar el as.factor
#Determinar el orden de la variable categorica
my_data2$Height <- factor(my_data2$Height, 
                   levels = c("Short", "Medium", "Tall"))

#mirar tipo de dato
class(my_data2$Height)
#Asignar una variable logica(dummy)
my_data2$women <- my_data2$Sex == "Female"
my_data2$women <- ifelse(my_data2$women, 1, 0)
#O tambien
my_data2$women <- factor(my_data2$Sex, 
                         levels = c("Male", "Female"))
my_data2
class(my_data2$women)

##Cambiar nombres a las variables de un dataframe
starwars
#Con everything() indicamos que selecciones el resto de variables en los datos
#Nos puede servir para darle cierto orden a el dataframe
sw <- starwars %>%
  select(name, height, mass, gender, everything())
view(sw)
sw2 <- starwars %>%
  select(name, height, mass) %>%
  #Renombramos variables  
  rename(weight = mass, altura = height)  
view(sw2)
##Más manipulación de datos
sw3 <- starwars %>%
  select(name, height, mass, gender) %>%
  rename(weight = mass) %>%
  na.omit() %>%
  mutate(height = height/100) %>%
  filter(gender %in% c("masculine", "feminine")) %>%
  mutate(women = recode(gender, 
                         masculine = 0,
                         feminine = 1)) %>%
  mutate(size = height > 1 & weight > 75,
         ##If_else, si pasa esto, pon esto y si no esto
         size = if_else(size == TRUE, "big", "small"))
view(sw3)


###Filtrar datos
view(msleep)

data_ <- msleep %>%
  select(name, sleep_total) %>%
  filter(sleep_total > 18)
view(msleep)

msleep2 <- msleep %>%
  select(name, sleep_total) %>%
  #Diferente de 
  filter(!sleep_total > 18)
view(msleep2)

my_data <- msleep %>%
  select(name, order, bodywt, sleep_total) %>%
  filter(order == "Primates", bodywt >20)
view(my_data)

my_data1 <- msleep %>%
  select(name, order, bodywt, sleep_total) %>%
  #| significa o, al pone una coma es como un &
  #En este caso que los datos sean primates o que su peso sea mayor a 20
  filter(order == "Primates" | bodywt > 20)
view(my_data1)

my_data2 <- msleep %>%
  select(name, sleep_total) %>%
  filter(name == "Cow" |
           name == "Dog" |
           name == "Goat")
view(my_data2)
#Con el siguiente codigo hacemos lo mismo que el anterior
my_data2 <- msleep %>%
  select(name, sleep_total) %>%
  filter(name %in% c("Cow", "Dog", "Horse"))
view(my_data2)

my_data3 <- msleep %>%
  select(name, sleep_total) %>%
  filter(between(sleep_total, 16, 18))
view(my_data3)

my_data4 <- msleep %>%
  select(name, sleep_total) %>%
  #Cercano a 17 en un rango de 0.5
  filter(near(sleep_total, 17, tol = 0.5))
view(my_data4)

my_data5 <- msleep %>%
  select(name, conservation,sleep_total) %>%
  #Filtrar si tiene valores nan
  filter(is.na(conservation))
view(my_data5)

my_data6 <- msleep %>%
  select(name, conservation,sleep_total) %>%
  #Filtrar si tiene valores nan
  filter(!is.na(conservation))
view(my_data6)