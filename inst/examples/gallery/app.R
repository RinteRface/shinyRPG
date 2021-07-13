library(shiny)
library(shinyRPG)

ui <- rpgPage(
  rpgContainer(
    rpgProgress("progress", 10),
    rpgButton("update", "Update slider"),
    rpgSlider("slider", "Slider", 0, 100, 50, golden = TRUE),
    rpgCheckbox("checkbox", "Check me!"),
    rpgRadio("radio", "Choose one", names(mtcars)),
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

  observeEvent(c(input$checkbox, input$radio), {
    if (input$checkbox) showNotification("Hello")
    showNotification(input$radio)
  })
}

shinyApp(ui, server)
