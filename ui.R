library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Macroeconomic Time Series Clustering"),

  # Sidebar 
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
    ),
    tags$hr(),
    selectInput("sep", "Column separator", c(",", ";"), selected = ","),
    selectInput("dec", "Decimals", c(".", ","), selected = "."),
    textInput ("main", "Type title of the graph", ""),
    textInput ("xlab", "Type title of the x axis", ""),
    textInput ("ylab", "Type title of the y axis", ""),
    checkboxInput ("rect", "Toggle cluster highlighting", value = FALSE),
    numericInput ("k", "Enter cutoff level for cluster highlighting", min = 1, max = 10, step = 1, value = 3),
    selectInput("rectcol", "Highlighting color:",
                c("Red" = "red",
                  "Green" = "green",
                  "Blue" = "blue"), selected = "red"),
    numericInput ("w", "Width of the graph", value = 400),
    numericInput ("h", "Height of the graph", value = 300)
    ),
 
    # Main panel 
    
    mainPanel(
 fluidPage(
          includeHTML("Description.html")
     ),
      imageOutput("distPlot")
    )
  )
))
