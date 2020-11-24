#Load packages

library("tidyverse")
library("maps")
library("mapproj")
library("lintr")
library("styler")

#Load in data

teen_preg <- read.csv("data/teen_preg_2016.csv")
requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")

#Filter data to 2016

abortions <- filter(
  abortions,
  year == "2016"
)

teen_abort <- full_join(abortions, requirement_level)
teen_abort <- teen_abort %>% 
  mutate(state = tolower(state))

contraceptives <- contraceptives %>% 
  mutate(state = tolower(state))

teen_preg <- teen_preg %>% 
  mutate(state = tolower(state))

#Join pregnancy and abortion tables

teen_preg_and_abort <- na.omit(full_join(teen_preg, teen_abort))
summary_info <- na.omit(full_join(teen_preg_and_abort, contraceptives))

#Create summary info table

summary_info_grouped <- summary_info %>% 
  group_by(sex_ed) %>% 
  select(state_id, sex_ed, abortionrate, pregnancy_rate, total_contraceptives)

##############################Teen Pregnancy Chart##############################

teen_preg <- (teen_pregnancy_2016) %>% 
  group_by(sex_ed) %>% 
  select(state, state_id, pregnancy_rate, sex_ed)

teen_preg_chart <- ggplot(teen_preg) +
  geom_col(mapping = aes(
    x = reorder(state_id, pregnancy_rate), y = pregnancy_rate, fill = sex_ed)) +
  labs(x = "State", y = "Pregnancy Rate", fill = "Level of Sexual Education") +
  ggtitle("United States 2016 Teen Pregnancy by State ") +
  scale_fill_discrete(labels = c("Not Required", "Required", 
                                 "Required & Medically Accurate")) +
  coord_flip() 


##############################Teen Abortion Map#################################

requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
abortions <- filter(
  abortions,
  year == "2016"
)
teen_abort <- full_join(abortions, requirement_level)

teen_abort <- teen_abort %>% 
  mutate(state = tolower(state))

state_shape <- map_data("state") %>% 
  rename(state = region) %>% 
  full_join(teen_abort, by="state")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(), # remove axis lines
    axis.text = element_blank(), # remove axis labels
    axis.ticks = element_blank(), # remove axis ticks
    axis.title = element_blank(), # remove axis titles
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank() # remove border around plot
  )

teen_abort_map <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes(
      x = long, y = lat, group = group, fill = abortionrate),
    color = "white",
    size = .1
  ) +
  coord_map() +
  blank_theme +
  scale_fill_continuous(low = "slategray2", high = "mediumorchid2") +
  labs(fill = "Abortion Rate") +
  ggtitle("United States 2016 Teen Abortion")


#############################Contraceptive Chart################################

sex_education <- read.csv("data/sexeducation.csv")

comparison <- ggplot(data = sex_education,
                     aes(x= "states",  y = Total_Contraceptives) )  + 
  geom_boxplot()
