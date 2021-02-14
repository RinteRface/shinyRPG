
# shinyRPG

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/shinyRPG)](https://CRAN.R-project.org/package=shinyRPG)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of shinyRPG is to ...

## Installation

You can install the released version of shinyRPG from Github with:

``` r
remotes::install_github("RinteRface/shinyRPG")
```

## Example

This is a basic example which shows the template:

``` r
library(shiny)
library(shinyRPG)

ui <- rpgPage(
  rpgContainer(
    rpgProgress("progress", 10),
    rpgButton("update", "Update slider"),
    rpgSlider("slider", "Slider", 0, 100, 50, golden = TRUE),
    style = "framed-golden"
  )
)

server <- function(input, output, session) {
  observe({
    print(
      list(
        button = input$update,
        slider = input$slider
      )
    )
  })
  
  observeEvent({
    req(input$update > 0)
    input$update
  }, {
    updateRpgSlider("slider", 50)
    updateRpgProgress("progress", color = "green")
  })
  
  observeEvent(input$slider, {
    updateRpgProgress("progress", value = input$slider)
  })
}

shinyApp(ui, server)
```

__Note__: valid JS instances are checkbox, draggable, progress, radio, dropdown, list and slider.
