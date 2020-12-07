# Load in data

requirement_level <- read.csv("data/state_level_requirement.csv")
abortions <- read.csv("data/nationalandstatepregnancy.csv")
contraceptives <- read.csv("data/contraceptives.csv")
teen_pregnancy_2016 <- read.csv("data/teen_preg_2016.csv")

source("scripts/app_server.R")

#Adjust header font

header_font <- tags$head(
  tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Crimson+Text:wght@600&display=swap');
      
      h1 {
        font-family: 'Crimson Text', serif;
        font-weight: 600;
      }

    ")
  )
)

#Introduction Page

intro_page <- tabPanel(
  "Introduction",
  mainPanel(
    h2("The State of Sexual Education"),
    p("In this project we examine three different data sets all surrounding the
    theme of sexual education in the United States and how it impacts sexual 
    health. The data includes information about teen pregnancy, teen abortion 
    rates, and contraceptive use amongst all states. Abortion rate and pregnancy rates
    were measured by abortions and pregnancies per 1000 women aged 15-19. Contraceptive
    use was measured as a percent of women aged 15-49. The level of sexual education
    taught in public high schools is determined at the state level. We found that
    there are three basic categories: (1) RMA, in which schools are required to 
    teach sex-ed and it must be medically accurate, (2) R, where schools are required
    to teach sex-ed, but the curriculum is not regulated, and (3) NR, where schools 
    are not at all obligated by the state government to teach any form of sexual 
    education. In this project we seek to determine possible correlations between the
    level of sexual education in each state and the measures of sexual health listed above."),
    
    p("Using information from each of the datasets, we calculated six summary statistics 
    to get a basic understanding of our data. We determined that New York had the highest 
    teen abortion rate at 17.7 and Arkansas had the highest teen pregnancy rate at 45.9.
    The state with the highest contraception use was Maine, at 87.9%."),
    
    p("We sourced our data from one main place. The pregnancy data, the
      abortion data, and the contraceptive use data all came from the Guttmacher 
      Institute, which is a pro-choice research and policy organization. We also used information
      from the federal and state governments to determine the level of sexual education
      in each state, as well as research reports from Planned Parenthood to determine
      a rough timeline of sexual education legislation."),
   
     tags$img(src = "https://www.marriagegeek.com/wp-content/uploads/2018/05/sexbaby.png")  
  )
)

category_names <- unique(teen_preg$Sexual_Education)

category_input <- selectInput(
  inputId = "category_input",
  label = "Choose Level of Sexual Education",
  choices = category_names
)

#Teen Pregnancy Page

preg_page <- tabPanel(
  "Teen Pregnancy",
  sidebarLayout(
    sidebarPanel(
      category_input
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

year_input <- sliderInput(
  inputId = "year_input",
  label = "Choose a Year",
  min = 2005,
  max = 2016,
  value = 2016,
  step = 1,
  sep = ""
)


abortion_page <- tabPanel(
  "Teen Abortion",
  sidebarLayout(
    sidebarPanel(
      year_input
    ),
    mainPanel(
      h2("Teen Abortion Visualization"),
      plotlyOutput("map"),
      p("This map was intended to show the relationship between the level of 
        sex-education and the rate of teen abortion in each state. We found that 
        the average rate of teen abortions across the three categories does not 
        vary by a significant amount. However, there are more things to 
        consider, such as population, sex-health resources, and regional 
        cultural differences. This map can display the abortion rate data for 
        12 years. We found that abortion rates were much higher in 2005, and they 
        have steadily been decreasing up until the most recent year included in 
        the data, 2016.")
    )
  )
)

adjusted_con <- renamed_contraceptives %>% 
  select(-State, -Sexual_Education)

contraceptive_type <- colnames(adjusted_con)

contraception_input <- selectInput(
  inputId = "y_input",
  label = "Choose a Y Value",
  choices = contraceptive_type
)


contraception_page <- tabPanel(
  "Contraception",
  sidebarLayout(
    sidebarPanel(
      contraception_input
    ),
    mainPanel(
      h2("Contraception Visualization"),
      plotlyOutput("scatter"),
      p("Every state uses different contraceptives to different extents, while 
        some states have very few people that use them. To analyze the use of 
        these contraceptives, we created a scatter plot showing the 
        percentage of women age 15-49 that use contraceptives in all 
        states. The data that we used separated different types of contraceptives,
        which we included in the dropdown menu, allowing users to compare states
        for each type of contraceptive, as well as a total of all contraceptives used.
        We also organize this data by the sexual education requirement 
        level for each state.")
    )
  )
)

summary_page <- tabPanel(
  "Summary",
  mainPanel(
    h2("Summary Analysis"),
    
    p("Our goal for this project was to see if there is a connection between the teen pregnancy rates, teen abortion 
      rates, and teen contraceptive use in each state to the level of sexual education
      mandated. There are 19 states that do not require any form of sex-ed to be taught (NR), 
      20 states that require sex-ed, but do not regulate the curriculum (R), and 12 states 
      that require medically accurate sex-ed (RMA)."),
    
    h3("Teen Pregnancy"),
    p("Looking at teen pregnancy rates across all states in 2016, we found that the average 
      teen pregnancy rate for NR states is 32.59. For R states, the average rate was 
      34.34, and the average for RMA states was 28.92. While the average for R was higher 
      than it was for NR, the lowest average teen pregnancy rate occurred in RMA states, 
      which is what we hoped to see. The individual state with the lowest teen 
      pregnancy rate was New Hampshire, which is an R state, at 17.5. The state with 
      the highest teen pregnancy rate was Arkansas, an NR state, at 45.9."),
    
    h3("Teen Abortion"),
    p("The interactive map we made to visualize teen abortions by state over a 12 year span 
      showed a significant decrease in teen abortion rates from 2005 to 2016. We found that 
      federal funding for abstinence only programs shot up from $80 million in 2001 to $167 
      million in 2005. However, many states wanted to incorporate more comprehensive sex-ed. 
      In the late 2000's, research found comprehensive sex-ed to postively impact 
      the sexual behavior in teens. The Obama administration recognized the 
      effectiveness of evidence-based sex-ed programs and transferred funds from 
      the Community-based Abstinence Program and budgeted $190 million for two new 
      programs: Teen Pregnancy Prevention Program (TPPP) and Personal Responsibility 
      Education Program (PREP)."),
    
    h3("Contraceptive Use"),
    p("The category with the highest average rate of contraceptive use was RMA at 76.86, while
    the category with the lowest average use was R at 73.12. However, NR was not ahead by much
    at 74.81. The state with the highest total contraception use is Maine, a state that 
    requires medically accurate sexual education, at 84.1%. The state with the 
    second lowest contraception use is Arizona, a state that does not require any 
    form of sexual education, at 67.4%. Overall, the states with higher contraception 
    use have mandated medically accurate sexual education, while those with  
    lower contraception use rates have none.")
  )
)

# Render fluid page

ui <- fluidPage(
  header_font,
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