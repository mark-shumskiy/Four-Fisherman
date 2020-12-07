library("tidyverse")
library("plotly")

contraceptives <- read.csv("data/contraceptives.csv")

contraceptive_table <- contraceptives %>% 
  select(state, total_contraceptives, sex_ed)

contraceptive_plot <- ggplot(contraceptive_table) +
  geom_point(mapping = aes(x = state, y = total_contraceptives, fill = sex_ed )) +
  labs(x = "State", 
       y = "Percent of Women Who Use Contraceptives (age 15-49)", 
       fill = "Sex Ed") +
  ggtitle("United States 2016 Contraceptive Use") +
  theme(axis.text.x = element_text(angle = 90))

contraceptive_chart <- ggplotly(contraceptive_plot)



