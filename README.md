# Cultometer: Group Dynamics Analysis Tool
![Screenshot 2024-11-19 at 12 12 39 AM](https://github.com/user-attachments/assets/09606ea2-d92d-481b-a5f3-e599c9a15955)

## Live Demo

Try the Cultometer here: [https://gigikenneth.shinyapps.io/cultometer/](https://gigikenneth.shinyapps.io/cultometer/)

## Overview

The Cultometer is a Shiny application that provides an interactive tool for analyzing group dynamics and patterns. It helps identify characteristics that might be associated with different types of group structures (community, religious group, or potentially concerning group dynamics). 

## Installation

### Prerequisites
Make sure you have R installed on your system. The Cultometer requires the following R packages:
```R
install.packages(c(
  "shiny",
  "shinythemes",
  "plotly"
))
```

### Directory Structure
```
cultometer/
├── global.R           # Global configurations and package loading
├── ui.R              # User interface definition
├── server.R          # Server logic
├── README.md         # This file
├── R/
│   ├── constants.R   # Constants and data definitions
│   └── plots.R       # Plot generation functions
└── www/
    └── custom.css    # Custom styling
```

## Running the Application
You can either:
1. Access the live version at [https://gigikenneth.shinyapps.io/cultometer/](https://gigikenneth.shinyapps.io/cultometer/)

Or run locally:
1. Clone or download this repository
2. Open R/RStudio
3. Set your working directory to the project folder
4. Run the following command:
```R
shiny::runApp()
```

## Application Components

### Input Categories
1. **Basic Information**
   - Group age
   - Size
   - Decision-making structure

2. **Additional Information**
   - Meeting frequency
   - Communication methods
   - Common activities

3. **Group Dynamics Assessment**
   - Member autonomy
   - Resource sharing
   - External interactions
   - Control mechanisms
   - Identity maintenance
   - Time and resource commitment
   - Information access
   - Leadership approach
   - Group practices
   - Belief systems

### Visualizations
- **Group Dynamic Patterns**: Bar chart showing relative scores across different categories
- **Radar Plot**: Visual representation of balance between different characteristics
- **Activity Distribution**: Donut chart showing distribution of group activities
- **Engagement Gauge**: Overall engagement level measurement
- **Activity Analysis**: Detailed breakdown of activity patterns
- **Engagement Patterns**: Projected engagement over time

## Customization
The application uses a pastel color scheme defined in `constants.R`. You can modify the colors by adjusting the `COLORS` list:
```R
COLORS <- list(
  background = '#fff5f5',
  primary = '#b5d3e7',
  secondary = '#9fc1d9',
  text = '#2c3e50',
  header = '#7c8495',
  chart_colors = c('#FFB3B3', '#B3FFB3', '#B3B3FF', '#FFB3FF', '#FFFFB3', '#B3FFFF')
)
```

---
Developed for educational and research purposes (okay, just kidding, mostly for fun). The Cultometer aims to promote understanding of group dynamics and raise awareness about potential warning signs in group structures.



Uploading Screen Recording 2024-11-19 at 12.08.47 AM.mp4…


