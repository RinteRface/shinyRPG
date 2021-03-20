
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
    rpgCheckbox("checkbox", "Check me!"),
    rpgSelect("variable", "Variable:",
              c("Cylinders" = "cyl",
                "Transmission" = "am",
                "Gears" = "gear")),
    rpgSelect("variable2", "Variable 2:",
              c("Cylinders" = "cyl",
                "Transmission" = "am",
                "Gears" = "gear"), size = 3),
    style = "framed-golden"
  )
)

server <- function(input, output, session) {
  observe({
    print(
      list(
        button = input$update,
        slider = input$slider,
        checkbox = input$checkbox,
        select = input$variable,
        list = input$variable2
      )
    )
  })
  
  observeEvent({
    req(input$update > 0)
    input$update
  }, {
    updateRpgSlider(session, "slider", 50)
    updateRpgProgress("progress", color = "green")
    updateRpgSelect(session, inputId = "variable2", selected = "gear")
  })
  
  observeEvent(input$slider, {
    updateRpgProgress("progress", value = input$slider)
  })

  observeEvent(input$checkbox, {
    if (input$checkbox) showNotification("Hello")
  })
}

shinyApp(ui, server)
```

__Note__: valid JS instances are checkbox, draggable, progress, radio, dropdown, list and slider.
