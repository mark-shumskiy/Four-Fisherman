# Load in data

requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")
teen_pregnancy_2016 <- read.csv("data/teen_preg_2016.csv")

#Filter teen pregnancy data

teen_preg <- (teen_pregnancy_2016) %>% 
  group_by(sex_ed) %>% 
  select(state, state_id, pregnancy_rate, sex_ed)

#Filter and adjust teen abortion data

teen_abort <- full_join(abortions, requirement_level)

teen_abort <- teen_abort %>% 
  mutate(state = tolower(state))

state_shape <- map_data("state") %>% 
  rename(state = region) %>% 
  full_join(teen_abort, by="state")

#Create blank theme for teen abortion map

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

#Create server and feed in teen pregnancy, abortion, and contraception charts

server <- function(input, output) {
  output$bar <- renderPlotly({
    bar_data <- teen_preg %>% 
      filter(sex_ed == input$category_input)
    teen_preg_chart <- ggplot(bar_data) +
      geom_col(mapping = aes(
        x = reorder(state_id, pregnancy_rate), y = pregnancy_rate, fill = sex_ed)) +
      labs(x = "State", y = "Pregnancy Rate (age 15-19)", fill = "Level of Sexual Education") +
      ggtitle("United States 2016 Teen Pregnancy by State") +
      theme(axis.text.x = element_text(angle = 90))
    
    ggplotly(teen_preg_chart)
  })
  
  output$map <- renderPlotly({
    map_chart <- state_shape %>% 
      filter(year == input$year_input)
    teen_abort_map <- ggplot(map_chart) +
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
      ggtitle("United States Teen Abortion (age 15-19)")
    
    ggplotly(teen_abort_map)
  })
  
  output$scatter <- renderPlotly({contraceptive_plot <- ggplot(contraceptives) +
    geom_point(mapping = aes_string(x = "state", y = input$y_input, 
                                    fill = "sex_ed" )) +
    labs(x = "State", 
         y = "Percent of Women Who Use Contraceptives (age 15-49)", 
         fill = "Sex Ed") +
    ggtitle("United States 2016 Contraceptive Use") +
    theme(axis.text.x = element_text(angle = 90))
  
  ggplotly(contraceptive_plot)
    
  })
}