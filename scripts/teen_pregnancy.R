library("tidyverse")

teen_preg <- (Teen_Pregnancy_2016) %>% 
  group_by(sex_ed) %>% 
  summarize(state, state_id, pregnancy_rate, sex_ed)

ggplot(teen_preg) +
geom_col(mapping = aes(
    x = state_id, y = pregnancy_rate, fill = sex_ed)) +
  coord_flip() 
