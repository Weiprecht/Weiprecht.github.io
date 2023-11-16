library(shiny)
library(ggplot2)
library(readr)

# beerPath <- "D:/Website/SimpleWebsite/Weiprecht.github.io/Beer_folder/beer_updated.csv"
# beer_data <- read.csv(beerPath, header = TRUE)

# URL to the raw content of the CSV file on GitHub
github_url <- "https://raw.githubusercontent.com/Weiprecht/Weiprecht.github.io/main/Beer_folder/beer_updated.csv"

# Read the CSV file from the GitHub repository
beer_data <- read_csv(github_url)

# UI part
ui <- fluidPage(
  titlePanel("Beer Dataset Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("stateInput", "Select State:",
                  choices = c("All", unique(beer_data$State))),
      selectInput("varInput", "Select Variable:",
                  choices = c("IBU", "ABV")),
      actionButton("returnButton", "Return to Previous Page")  # New button
    ),
    mainPanel(
      plotOutput("histogram")
    )
  )
)

# Server part
server <- function(input, output, session) {  # Added 'session'
  binwidth <- reactiveVal(1)  # Initialize with default value for IBU
  
  filtered_data <- reactive({
    req(input$stateInput, input$varInput)
    
    if (input$stateInput == "All") {
      filtered <- beer_data
    } else {
      filtered <- beer_data[beer_data$State == input$stateInput, ]
    }
    
    # Filter based on the selected variable (IBU or ABV)
    if (input$varInput == "IBU") {
      binwidth(3)  # Set binwidth to 1 for IBU
      filtered <- filtered[, c("State", "IBU")]
    } else {
      binwidth(0.01)  # Set binwidth to 0.01 for ABV
      filtered <- filtered[, c("State", "ABV")]
    }
    
    filtered
  })
  
  output$histogram <- renderPlot({
    ggplot(filtered_data(), aes_string(x = input$varInput)) +
      geom_histogram(binwidth = binwidth(), fill = "blue", color = "black") +
      labs(x = input$varInput, y = "Frequency", title = "Count of Beer Observations at the Selected Level (IBU, ABV)")
  })
  
  observeEvent(input$returnButton, {  # Event handler for the button
    runjs("history.go(-1);")  # JavaScript to navigate back one page
    #session$close()  # Close the Shiny app session
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

