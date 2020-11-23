library("tidyverse")
library("dplyr")
sex_education <- read.csv("data/sexeducation.csv")

comparison <- ggplot(data = sex_education,
                     aes(x=  "states",  y = Total_Contraceptives) )  + 
  geom_boxplot()