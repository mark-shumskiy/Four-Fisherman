################ Chart 1: Abortion Rates ################

library("tidyverse")
library("ggplot2")
install.packages("maps")
install.packages("mapproj")
library("maps")
library("mapproj")

# read in the data about the three different categories of states
# and the data about abortion rates by state
requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")

# filter out all years except 2016 from abortions
abortions <- filter(
  abortions,
  year == "2016"
)

# combine the two tables
teen_abort <- full_join(abortions, requirement_level)
teen_abort <- teen_abort %>% 
  mutate(state = tolower(state))
View(teen_abort)

# group by requirement level
# teen_abort_by_level <- teen_abort %>% 
# group_by(requirement_level) %>% 
# summarise(state_id, abortionratelt20, requirement_level)

# make a chart
state_shape <- map_data("state") %>% 
  rename(state = region) %>% 
  full_join(teen_abort, by="state")
View(state_shape)

ggplot(state_shape) +
  geom_polygon(
    mapping = aes(
      x = long, y = lat, group = group, fill = abortionratelt20),
    color = "white",
    size = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "slategray2", high = "mediumorchid2") +
  labs(fill = "Abortion Rate")
