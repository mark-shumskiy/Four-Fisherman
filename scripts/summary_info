################ Summary Information Script ################

library("tidyverse")

# import data
teen_preg <- read.csv("data/teen_preg_2016.csv")
requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")

# filter out all years except 2016 from abortions
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

# state w highest abortion rate and the rate
abortion_rate_max <- teen_preg_and_abort %>%
  filter(abortionratelt20 == max(abortionratelt20)) %>% 
  pull(abortionratelt20)

abortion_state_max <- teen_preg_and_abort %>%
  filter(abortionratelt20 == max(abortionratelt20)) %>% 
  pull(state)

# state with highest teen preg rate and the rate
teenpreg_rate_max <- teen_preg_and_abort %>% 
  filter(pregnancy_rate == max(pregnancy_rate)) %>% 
  pull(pregnancy_rate)

teenpreg_state_max <- teen_preg_and_abort %>% 
  filter(pregnancy_rate == max(pregnancy_rate)) %>% 
  pull(state)

# state w highest rate of contraceptive use and rate
cont_rate_max <- summary_info %>% 
  filter(Total_Contraceptives == max(Total_Contraceptives)) %>% 
  pull(Total_Contraceptives)

cont_state_max <- summary_info %>% 
  filter(Total_Contraceptives == max(Total_Contraceptives)) %>% 
  pull(state)

# make a list
summary_list <- list(
  abortion_rate_max,
  abortion_state_max,
  teenpreg_rate_max,
  teenpreg_state_max,
  cont_rate_max,
  cont_state_max
)

