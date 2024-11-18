characteristics <- data.frame(
  label = c(
    "How much say do members have in their personal choices?",
    "What level of giving or sharing resources is expected?", 
    "How much do members interact with people outside the group?",
    "How enthusiastically do members share about the group with others?",
    "How freely can members access different viewpoints?",
    "How does the group respond when members feel doubt or uncertainty?",
    "To what extent can members maintain their previous identity and interests?",
    "How central are group-specific practices to daily life?",
    "How unique or special does the group consider its beliefs/knowledge?",
    "What portion of members' free time goes to group activities?"
  ),
  cult_weight_multiplier = c(3, 3, 3, 3, 3, 3, 3, 2, 3, 3),
  religion_weight_multiplier = c(1, 2, 1, 1, 1, 1, 1, 3, 2, 2),
  community_weight_multiplier = c(0, 1, 0, 1, 0, 0, 0, 1, 0, 1)
)

slider_labels <- list(
  list("Complete freedom", "Some input", "No choice"),
  list("Optional", "Expected", "Mandatory"),
  list("Unrestricted", "Limited", "Discouraged"),
  list("Personal choice", "Encouraged", "Pressured"),
  list("Open access", "Guided access", "Restricted"),
  list("Supportive", "Concerned", "Punitive"),
  list("Fully maintained", "Partially", "Completely new"),
  list("Optional", "Regular", "Constant"),
  list("One perspective", "Special insight", "Exclusive truth"),
  list("Flexible", "Significant", "All-consuming")
)

# Update the COLORS list with Material You palette
COLORS <- list(
  background = '#fcfcff',
  primary = '#006495',
  secondary = '#50606f',
  tertiary = '#66587b',
  surface = '#fcfcff',
  surface_variant = '#dce3ea',
  error = '#ba1a1a',
  on_primary = '#ffffff',
  on_surface = '#1a1c1e',
  chart_colors = c('#cde5ff', '#d3e5f5', '#eddbff', '#ffdad6', '#dce3ea', '#e8deff')
)