
# Material You color palette
MATERIAL_COLORS <- list(
  primary = "#006495",
  secondary = "#50606f",
  tertiary = "#66587b",
  surface = "#fcfcff",
  pastel = list(
    red = "#FFB4AB",
    blue = "#BAC8FF",
    green = "#9CD9BB",
    purple = "#E8B7FF",
    cyan = "#97DDEC"
  ),
  text = "#1A1C1E"
)

create_scores_plot <- function(scores) {
  plot_ly() %>%
    add_bars(x = names(scores), y = scores,
             marker = list(color = c(MATERIAL_COLORS$pastel$red, 
                                     MATERIAL_COLORS$pastel$blue, 
                                     MATERIAL_COLORS$pastel$green))) %>%
    layout(
      title = list(
        text = "Group Dynamic Patterns",
        font = list(
          family = "Google Sans",
          size = 20,
          color = MATERIAL_COLORS$text
        ),
        y = 0.95
      ),
      yaxis = list(
        title = list(
          text = "Score",
          font = list(family = "Google Sans")
        ),
        gridcolor = "#E1E1E1"
      ),
      xaxis = list(
        title = list(
          text = "Group Type",
          font = list(family = "Google Sans")
        )
      ),
      paper_bgcolor = MATERIAL_COLORS$surface,
      plot_bgcolor = MATERIAL_COLORS$surface,
      showlegend = FALSE,
      margin = list(t = 50, b = 40, l = 40, r = 20)
    )
}

create_radar_plot <- function(scores) {
  max_score <- max(scores)
  
  plot_ly(
    type = 'scatterpolar',
    mode = 'lines'
  ) %>%
    add_trace(
      r = c(scores["cult"], scores["religion"], scores["community"], scores["cult"]),
      theta = c("High Control", "Traditional", "Open", "High Control"),
      fill = 'toself',
      fillcolor = paste0(MATERIAL_COLORS$primary, "40"),  # 40 is hex for 25% opacity
      line = list(color = MATERIAL_COLORS$primary)
    ) %>%
    layout(
      polar = list(
        radialaxis = list(
          visible = TRUE,
          range = c(0, max_score),
          gridcolor = "#E1E1E1"
        ),
        bgcolor = MATERIAL_COLORS$surface
      ),
      title = list(
        text = "Group Dynamic Distribution",
        font = list(
          family = "Google Sans",
          size = 20,
          color = MATERIAL_COLORS$text
        ),
        y = 0.95
      ),
      paper_bgcolor = MATERIAL_COLORS$surface,
      showlegend = FALSE,
      margin = list(t = 50, b = 40, l = 40, r = 40)
    )
}

create_activity_chart <- function(activities) {
  if(length(activities) == 0) activities <- "None selected"
  
  activity_counts <- table(factor(activities, 
                                  levels = c("social", "study", "recruit", "fundraise", "service", "None selected")))
  
  plot_ly() %>%
    add_pie(
      labels = names(activity_counts), 
      values = as.numeric(activity_counts),
      hole = 0.6,
      marker = list(
        colors = c(
          MATERIAL_COLORS$pastel$red,
          MATERIAL_COLORS$pastel$blue,
          MATERIAL_COLORS$pastel$green,
          MATERIAL_COLORS$pastel$purple,
          MATERIAL_COLORS$pastel$cyan,
          "#E1E1E1"
        )
      )
    ) %>%
    layout(
      title = list(
        text = "Activity Distribution",
        font = list(
          family = "Google Sans",
          size = 20,
          color = MATERIAL_COLORS$text
        ),
        y = 0.95
      ),
      paper_bgcolor = MATERIAL_COLORS$surface,
      showlegend = TRUE,
      legend = list(
        font = list(family = "Google Sans"),
        bgcolor = MATERIAL_COLORS$surface
      ),
      margin = list(t = 50, b = 40, l = 20, r = 20)
    )
}

create_engagement_gauge <- function(scores) {
  max_possible <- 30
  engagement_score <- mean(scores) / max_possible * 100
  
  plot_ly() %>%
    add_trace(
      type = "indicator",
      mode = "gauge+number",
      value = engagement_score,
      title = list(
        text = "Overall Engagement Level",
        font = list(
          family = "Google Sans",
          size = 20,
          color = MATERIAL_COLORS$text
        )
      ),
      number = list(
        font = list(
          family = "Google Sans",
          size = 40,
          color = MATERIAL_COLORS$primary
        ),
        suffix = "%"
      ),
      gauge = list(
        axis = list(
          range = list(0, 100),
          tickfont = list(family = "Google Sans")
        ),
        bar = list(color = MATERIAL_COLORS$primary),
        bgcolor = MATERIAL_COLORS$surface,
        borderwidth = 0,
        steps = list(
          list(range = c(0, 33), color = paste0(MATERIAL_COLORS$pastel$red, "40")),
          list(range = c(33, 66), color = paste0(MATERIAL_COLORS$pastel$blue, "40")),
          list(range = c(66, 100), color = paste0(MATERIAL_COLORS$pastel$green, "40"))
        )
      )
    ) %>%
    layout(
      paper_bgcolor = MATERIAL_COLORS$surface,
      margin = list(t = 60, b = 20, l = 20, r = 20)
    )
}

create_activity_breakdown <- function(results) {
  meeting_scores <- data.frame(
    Category = c("Engagement", "Commitment", "Social"),
    Score = c(
      ifelse(results$meetings == "frequent", 8, 
             ifelse(results$meetings == "regular", 5, 3)),
      mean(results$scores),
      length(results$activities) * 2
    )
  )
  
  plot_ly(meeting_scores, x = ~Category, y = ~Score, type = "bar",
          marker = list(
            color = c(
              MATERIAL_COLORS$pastel$red,
              MATERIAL_COLORS$pastel$blue,
              MATERIAL_COLORS$pastel$green
            )
          )) %>%
    layout(
      title = list(
        text = "Engagement Analysis",
        font = list(
          family = "Google Sans",
          size = 20,
          color = MATERIAL_COLORS$text
        ),
        y = 0.95
      ),
      yaxis = list(
        title = list(
          text = "Score",
          font = list(family = "Google Sans")
        ),
        gridcolor = "#E1E1E1"
      ),
      xaxis = list(
        title = list(
          text = "Category",
          font = list(family = "Google Sans")
        )
      ),
      paper_bgcolor = MATERIAL_COLORS$surface,
      plot_bgcolor = MATERIAL_COLORS$surface,
      showlegend = FALSE,
      margin = list(t = 50, b = 40, l = 40, r = 20)
    )
}

create_meeting_patterns <- function(scores) {
  time_points <- 1:10
  engagement <- scores["community"] * (1 + sin(time_points/3))/2 +
    scores["religion"] * (1 + cos(time_points/4))/2 +
    scores["cult"] * (1 + sin(time_points/2))/2
  
  plot_ly(x = time_points, y = engagement, type = "scatter", 
          mode = "lines+markers",
          line = list(color = MATERIAL_COLORS$primary),
          marker = list(
            color = MATERIAL_COLORS$surface,
            size = 8,
            line = list(
              color = MATERIAL_COLORS$primary,
              width = 2
            )
          )) %>%
    layout(
      title = list(
        text = "Projected Engagement Pattern",
        font = list(
          family = "Google Sans",
          size = 20,
          color = MATERIAL_COLORS$text
        ),
        y = 0.95
      ),
      xaxis = list(
        title = list(
          text = "Time Period",
          font = list(family = "Google Sans")
        ),
        gridcolor = "#E1E1E1"
      ),
      yaxis = list(
        title = list(
          text = "Engagement Level",
          font = list(family = "Google Sans")
        ),
        gridcolor = "#E1E1E1"
      ),
      paper_bgcolor = MATERIAL_COLORS$surface,
      plot_bgcolor = MATERIAL_COLORS$surface,
      showlegend = FALSE,
      margin = list(t = 50, b = 40, l = 40, r = 20)
    )
}
