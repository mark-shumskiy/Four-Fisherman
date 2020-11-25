################ Chart 1: Abortion Rates ################

library("tidyverse")
library("ggplot2")
library("maps")
library("mapproj")

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
  ggtitle("United States 2016 Teen Abortion (age 15-19)")
