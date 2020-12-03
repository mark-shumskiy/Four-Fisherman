# Load in data

requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/NationalandStatePregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")
teen_pregnancy_2016 <- read.csv("data/teen_preg_2016.csv")

#Introduction Page

intro_page <- tabPanel(
  "Introduction",
  mainPanel(
    h2("Sexual Education in the United States"),
    p("In this project we examine three different data sets all surrounding the
    theme of sexual education in the United States and how it impacts sexual 
    health. The data includes information about teen pregnancy, teen abortion 
    rates, and contraceptive use amongst all states in the year 2016. It also
    includes the level of sex education present within each state, 
    (RMA = required to be medically accurate, R = required 
    (not medically accurate), NR = not required). In the project we seek to 
    determine possible correlations between the level of sexual education in 
    each state and the measures of sexual health listed above."),
    
    p("Using our summary information function we calculated six main pieces of 
      information about our datasets. We determined that New York had the 
      highest teen abortion rate at 17.7 (abortions per 1000 women aged 15-19), 
      Arkansas had the highest teen pregnancy rate at 45.9 
      (pregnancies per 1000 women aged 15-19), and Maine had the highest 
      contraception use at 87.9%  (as a percentage for women age 15-49)."),
    
    p("We created an aggregate table that looked a variety of variables relating
      to our three areas of focus: teen pregnancy, teen abortions, and 
      contraceptive use. By grouping the states by their level of required 
      sex-education (not required, required and must be medically accurate, and 
      required but not required to be medically accurate) we were able to 
      ascertain a clearer picture. It seemed like the percentage of the 
      population using contraceptives in each state was not very different 
      across the three categories. This could partly be due to the age range 
      from which we used data for contraceptive use, that being 15-49, instead 
      of purely teens. Another observation we made was that on average the rate 
      of teen pregnancy was lower in states that require medically accurate 
      sex-education than states of the other two categories. Similarly, it looks
      like states which require medically accurate sex-education tend to have 
      lower abortion rates in teens.")
  )
)

#Teen Pregnancy Page

preg_page <- tabPanel(
  "Teen Pregnancy",
  sidebarLayout(
    sidebarPanel(
      #y_input,
      #year_input
    ),
    mainPanel(
      h2("Teen Pregnancy Visualization"),
      plotlyOutput("bar"),
      p("This chart was intended to show the relationship between the level of 
        sex-education and the rate of teen pregnancy in each state. We found 
        that the average rate of teen pregnancies in states that require 
        medically accurate sex-education is lower than that of states that 
        either do not require it or do not require the education to be medically 
        accurate.")
    )
  )
)

abortion_page <- tabPanel(
  "Teen Abortion",
  sidebarLayout(
    sidebarPanel(
      #y_input,
      #year_input
    ),
    mainPanel(
      h2("Teen Abortion Visualization"),
      plotlyOutput("map"),
      p("This map was intended to show the relationship between the level of 
        sex-education and the rate of teen abortion in each state. We found that 
        the average rate of teen abortions across the three categories does not 
        vary by a significant amount. However, there are more things to 
        consider, such as population, sex-health resources, and regional 
        cultural differences.")
    )
  )
)

contraception_page <- tabPanel(
  "Contraception",
  sidebarLayout(
    sidebarPanel(
      #y_input,
      #year_input
    ),
    mainPanel(
      h2("Contraception Visualization"),
      plotlyOutput("scatter"),
      p("Every state uses different contraceptives to different extents, while 
        some states have very few people that use them. To analyze the use of 
        these contraceptives, we created a scatter plot showing a summary of the 
        total percentage of women age 15-49 that use contraceptives in all 
        states. We also organize this data by the sexual education requirement 
        level for each state. The state with the highest contraception use is 
        Maine, a state that requires medically accurate sexual education, at 
        84.1%. The state with the second lowest contraception use is Arizona, a 
        state that does not require any form of sexual education, at 67.4% 
        Overall, the states with higher contraception use have mandated 
        medically accurate sexual education, while those with the lowest 
        contraception use have none.")
    )
  )
)

summary_page <- tabPanel(
  "Summary",
  mainPanel(
    p("This is where we would write a summary about our data and our project."),
  )
)

# Render fluid page

ui <- fluidPage(
  h1("United States Sexual Education"),
  navbarPage(
    inverse = TRUE,
    "Final Project: Sex Ed",
    intro_page,
    preg_page,
    abortion_page,
    contraception_page,
    summary_page
  )
)