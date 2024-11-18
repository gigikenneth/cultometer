ui <- fluidPage(
  theme = shinytheme("flatly"),
  includeCSS("www/custom.css"),
  
  titlePanel("Group Dynamics Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      width = 4,
      
      # Basic Information Section
      h4("Basic Information"),
      div(class = "section-card",
          selectInput("timeframe", 
                      "When did the group begin?",
                      choices = c("Recently" = "new",
                                  "A while ago" = "established",
                                  "Many years ago" = "old")),
          selectInput("size", 
                      "How many people are involved?",
                      choices = c("Close-knit group" = "small",
                                  "Growing community" = "medium",
                                  "Large organization" = "large")),
          selectInput("structure", 
                      "How are decisions made?",
                      choices = c("Central figure" = "single",
                                  "Leadership team" = "core",
                                  "Group consensus" = "democratic"))
      ),
      
      # Additional Questions Section
      h4("Additional Information"),
      div(class = "section-card",
          radioButtons("meetings", "How often do members meet?",
                       choices = c("Weekly or more" = "frequent",
                                   "Monthly" = "regular",
                                   "Occasionally" = "infrequent")),
          selectInput("communication", "Main form of communication?",
                      choices = c("In-person only" = "inperson",
                                  "Mixed methods" = "mixed",
                                  "Primarily online" = "online")),
          checkboxGroupInput("activities", "What activities are common?",
                             choices = c("Social gatherings" = "social",
                                         "Study sessions" = "study",
                                         "Recruitment events" = "recruit",
                                         "Fundraising" = "fundraise",
                                         "Service projects" = "service"))
      ),
      
      # Group Dynamics Section
      h4("Group Dynamics"),
      div(class = "section-card",
          lapply(1:nrow(characteristics), function(i) {
            div(
              class = "slider-container",
              sliderInput(
                inputId = paste0("char_", i),
                label = characteristics$label[i],
                min = 0, max = 5, value = 0, step = 1,
                ticks = FALSE,
                width = "100%"
              ),
              div(
                class = "slider-labels",
                tags$span(slider_labels[[i]][1]),
                tags$span(slider_labels[[i]][2]),
                tags$span(slider_labels[[i]][3])
              )
            )
          })
      ),
      
      actionButton("analyze", "Review Group Dynamics", 
                   class = "btn-primary btn-block")
    ),
    
    mainPanel(
      width = 8,
      tabsetPanel(
        tabPanel("Insights",
                 wellPanel(
                   h4("Analysis"),
                   uiOutput("result"),
                   br(),
                   textOutput("context_analysis")
                 ),
                 div(class = "chart-row",
                     div(class = "chart-card", plotlyOutput("scores_plot", height = "300px")),
                     div(class = "chart-card", plotlyOutput("radar_plot", height = "300px"))
                 ),
                 div(class = "chart-row",
                     div(class = "chart-card", plotlyOutput("activity_chart", height = "300px")),
                     div(class = "chart-card", plotlyOutput("engagement_gauge", height = "300px"))
                 )
        ),
        tabPanel("Detailed Analysis",
                 div(class = "section-card",
                     h4("Scoring Breakdown"),
                     dataTableOutput("breakdown_table")
                 ),
                 div(class = "chart-row",
                     div(class = "chart-card",
                         h4("Activity Analysis"),
                         plotlyOutput("activity_breakdown", height = "300px")
                     ),
                     div(class = "chart-card",
                         h4("Engagement Patterns"),
                         plotlyOutput("meeting_patterns", height = "300px")
                     )
                 )
        )
      )
    )
  )
)