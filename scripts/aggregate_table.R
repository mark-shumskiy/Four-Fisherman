################ Aggregate Table Script ################

library("tidyverse")

# import data
teen_preg <- read.csv("data/teen_preg_2016.csv")
requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")

# only want 2016
abortions <- filter(
  abortions,
  year == "2016"
)

# prepare to join
teen_abort <- full_join(abortions, requirement_level)
teen_abort <- teen_abort %>% 
  mutate(state = tolower(state))
View(teen_abort)
contraceptives <- contraceptives %>% 
  mutate(state = tolower(state))
teen_preg <- teen_preg %>% 
  mutate(state = tolower(state))
View(teen_preg)

# combine abortions with teen pregnancies
teen_preg_and_abort <- na.omit(full_join(teen_preg, teen_abort))
summary_info <- na.omit(full_join(teen_preg_and_abort, contraceptives))
View(summary_info)

# group the data by sex ed category
summary_info_grouped <- summary_info %>% 
  group_by(sex_ed) %>% 
  summarise(state_id, sex_ed, abortionrate, pregnancy_rate, total_contraceptives)
