################ Aggregate Table Script ################
############### to avoid merge conflicts, we collaborated over zoom ################

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
  mutate(state_id = tolower(state_id)) %>% 
  mutate(state = tolower(state))

contraceptives <- contraceptives %>% 
  mutate(state = tolower(state)) %>% 
  rename("state_id" = "state")

teen_preg <- teen_preg %>% 
  mutate(state_id = tolower(state_id)) %>% 
  mutate(state = tolower(state))

# combine abortions with teen pregnancies
teen_preg_and_abort <- full_join(teen_preg, teen_abort)
summary_info <- left_join(teen_preg_and_abort, contraceptives)


# group the data by sex ed category
aggregate_table <- summary_info %>% 
  group_by(sex_ed) %>% 
  mutate(state_id = toupper(state_id)) %>% 
  select(state_id, sex_ed, abortionrate, pregnancy_rate,
         total_contraceptives) %>% 
  rename("State" = "state_id") %>% 
  rename("Sexual Education" = "sex_ed") %>% 
  rename("Abortion Rate" = "abortionrate") %>% 
  rename("Pregnancy Rate" = "pregnancy_rate") %>% 
  rename("Percentage of Total Contraceptive Use" = "total_contraceptives") 