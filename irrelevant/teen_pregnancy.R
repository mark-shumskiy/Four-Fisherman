library("tidyverse")

teen_pregnancy_2016 <- read.csv("data/teen_preg_2016.csv")

teen_preg <- (teen_pregnancy_2016) %>% 
  group_by(sex_ed) %>% 
  select(state, state_id, pregnancy_rate, sex_ed)

teen_preg_chart <- ggplot(teen_preg) +
geom_col(mapping = aes(
    x = reorder(state_id, pregnancy_rate), y = pregnancy_rate, fill = sex_ed)) +
  labs(x = "State", y = "Pregnancy Rate (age 15-19)", fill = "Level of Sexual Education") +
  ggtitle("United States 2016 Teen Pregnancy by State") +
  coord_flip() 
  
  