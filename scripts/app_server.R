# Load in data

requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")
teen_pregnancy_2016 <- read.csv("data/teen_preg_2016.csv")

#Filter and rename teen pregnancy data

teen_preg <- (teen_pregnancy_2016) %>% 
  group_by(sex_ed) %>% 
  select(state, state_id, pregnancy_rate, sex_ed) %>%
  rename("State" = "state") %>% 
  rename("Pregnancy_Rate" = "pregnancy_rate") %>% 
  rename("Sexual_Education" = "sex_ed")

#Filter and adjust teen abortion data

teen_abort <- full_join(abortions, requirement_level)

teen_abort <- teen_abort %>% 
  mutate(state = tolower(state))

state_shape <- map_data("state") %>% 
  rename(state = region) %>% 
  full_join(teen_abort, by="state") %>% 
  rename("Abortion_Rate" = "abortionrate")


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

#Rename Columns for contraception data

renamed_contraceptives <- contraceptives %>% 
  rename("Female_Sterilization" = "female_sterlization") %>% 
  rename("IUD" ="iud") %>% 
  rename("Birth_Control_Pill" = "pill") %>% 
  rename("Condom" = "condom") %>% 
  rename("None" = "none") %>% 
  rename("Other" = "other") %>% 
  rename("Total_Contraceptives" = "total_contraceptives") %>% 
  rename("Sexual_Education" = "sex_ed") %>% 
  rename("State" = "state")
  
#Create server and feed in teen pregnancy, abortion, and contraception charts

server <- function(input, output) {
  output$bar <- renderPlotly({
    bar_data <- teen_preg %>% 
      filter(Sexual_Education == input$category_input)
    teen_preg_chart <- ggplot(bar_data) +
      geom_col(mapping = aes(
        x = reorder(state_id, Pregnancy_Rate), y = Pregnancy_Rate, fill = Sexual_Education)) +
      labs(x = "State", y = "Pregnancy Rate (age 15-19)", fill = "Sex Ed") +
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
          x = long, y = lat, group = group, fill = Abortion_Rate),
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
  
  output$scatter <- renderPlotly({contraceptive_plot <- ggplot(renamed_contraceptives) +
    geom_point(mapping = aes_string(x = "State", y = input$y_input, 
                                    fill = "Sexual_Education" )) +
    labs(x = "State", 
         y = "Percent of Women Using Contraceptives (age 15-49)", 
         fill = "Sex Ed") +
    ggtitle("United States 2016 Contraceptive Use") +
    theme(axis.text.x = element_text(angle = 90))
  
  ggplotly(contraceptive_plot)
    
  })
}