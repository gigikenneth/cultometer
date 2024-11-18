server <- function(input, output, session) {
  results <- reactiveVal(NULL)
  
  observeEvent(input$analyze, {
    slider_values <- sapply(1:nrow(characteristics), function(i) {
      input[[paste0("char_", i)]]
    })
    
    base_scores <- c(
      cult = sum(slider_values * characteristics$cult_weight_multiplier) * 2 / 5,
      religion = sum(slider_values * characteristics$religion_weight_multiplier) * 2 / 5,
      community = sum(slider_values * characteristics$community_weight_multiplier) * 2 / 5
    )
    
    modifiers <- c(cult = 0, religion = 0, community = 0)
    
    # Meeting frequency modifiers
    if(input$meetings == "frequent") {
      modifiers["cult"] <- modifiers["cult"] + 1
      modifiers["religion"] <- modifiers["religion"] + 1
    } else if(input$meetings == "infrequent") {
      modifiers["community"] <- modifiers["community"] + 1
    }
    
    # Communication method modifiers
    if(input$communication == "inperson") {
      modifiers["cult"] <- modifiers["cult"] + 1
    } else if(input$communication == "online") {
      modifiers["community"] <- modifiers["community"] + 1
    }
    
    # Activity-based modifiers
    activities <- input$activities
    if("recruit" %in% activities) modifiers["cult"] <- modifiers["cult"] + 1
    if("service" %in% activities) modifiers["community"] <- modifiers["community"] + 1
    if("study" %in% activities) modifiers["religion"] <- modifiers["religion"] + 1
    
    # Time-based modifications
    if(input$timeframe == "new") {
      modifiers["cult"] <- modifiers["cult"] + 2
      modifiers["community"] <- modifiers["community"] + 1
    } else if(input$timeframe == "established") {
      modifiers["religion"] <- modifiers["religion"] + 1
      modifiers["community"] <- modifiers["community"] + 2
    } else if(input$timeframe == "old") {
      modifiers["religion"] <- modifiers["religion"] + 2
    }
    
    # Size-based modifications
    if(input$size == "small") {
      modifiers["cult"] <- modifiers["cult"] + 1
      modifiers["community"] <- modifiers["community"] + 1
    } else if(input$size == "large") {
      modifiers["religion"] <- modifiers["religion"] + 2
    }
    
    # Leadership structure modifications
    if(input$structure == "single") {
      modifiers["cult"] <- modifiers["cult"] + 2
    } else if(input$structure == "democratic") {
      modifiers["community"] <- modifiers["community"] + 2
    }
    
    scores <- base_scores + modifiers
    
    max_score <- max(scores)
    types <- names(scores)[scores >= (max_score - 2)]
    
    concern_level <- ifelse(scores["cult"] > 20, "High",
                            ifelse(scores["cult"] > 15, "Moderate", "Low"))
    
    dynamics_message <- if (length(types) == 1) {
      HTML(paste("This group's dynamics most closely resemble a", types, 
                 "<br><br>",
                 sprintf("Level of concern: %s", concern_level)))
    } else {
      HTML(paste("This group shows characteristics of:", 
                 paste(types, collapse = " and "),
                 "<br><br>",
                 sprintf("Level of concern: %s", concern_level)))
    }
    
    context_message <- sprintf(
      "Context considered: %s group, %s size, %s-based decision making, %s meetings, %s communication",
      input$timeframe, input$size, input$structure, input$meetings, input$communication
    )
    
    results(list(
      message = dynamics_message,
      context = context_message,
      scores = scores,
      base_scores = base_scores,
      modifiers = modifiers,
      concern_level = concern_level,
      activities = input$activities,
      meetings = input$meetings
    ))
  })
  
  # Render outputs
  output$result <- renderUI({
    req(results())
    results()$message
  })
  
  output$context_analysis <- renderText({
    req(results())
    results()$context
  })
  
  output$scores_plot <- renderPlotly({
    req(results())
    create_scores_plot(results()$scores)
  })
  
  output$radar_plot <- renderPlotly({
    req(results())
    create_radar_plot(results()$scores)
  })
  
  output$activity_chart <- renderPlotly({
    req(results())
    create_activity_chart(results()$activities)
  })
  
  output$engagement_gauge <- renderPlotly({
    req(results())
    create_engagement_gauge(results()$scores)
  })
  
  output$activity_breakdown <- renderPlotly({
    req(results())
    create_activity_breakdown(results())
  })
  
  output$meeting_patterns <- renderPlotly({
    req(results())
    create_meeting_patterns(results()$scores)
  })
  
  output$breakdown_table <- renderDataTable({
    req(results())
    data.frame(
      Pattern = c("High Control", "Traditional", "Open"),
      Base_Score = round(results()$base_scores, 2),
      Context_Adjustment = results()$modifiers,
      Overall_Score = round(results()$scores, 2),
      Concern_Level = results()$concern_level
    )
  })
}