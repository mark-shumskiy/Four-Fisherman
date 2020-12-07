library("shiny")
library("tidyverse")
library("plotly")
library("maps")
library("mapproj")
library("lintr")
library("styler")

source("scripts/app_ui.R")
source("scripts/app_server.R")

shinyApp(ui = ui, server = server)
