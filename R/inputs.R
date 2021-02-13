#' @keywords internal
createElementClass <- function(element, golden) {
  cl <- sprintf("rpgui-%s", element)
  if (golden) cl <- paste(cl, "golden")
  cl
}


#' Create a slider input
#'
#' \link{rpgSlider} creates a slider input element.
#'
#' @param inputId \link{rpgSlider} unique id.
#' @param label Text writtent on top of the input.
#' @param min The minimum value (inclusive) that can be selected.
#' @param max The maximum value (inclusive) that can be selected.
#' @param value The initial value of the slider. Only single values supported.
#' @param golden Style parameter. If TRUE, the slider is bordered by fancy elements.
#' FALSE by default.
#'
#' @rdname rpg-slider
#' @export
#' @importFrom shiny tagList
rpgSlider <- function(inputId, label, min, max, value, golden = FALSE) {
  div(
    style = "margin: 5px",
    tags$label(label),
    tags$input(
      class = createElementClass("slider", golden),
      id = inputId,
      type = "range",
      min = min,
      max = max,
      value = value
    )
  )
}



#' Update slider on the server
#'
#' \link{updateRpgSlider} changes the slider value from the server.
#'
#' @param inputId \link{rpgSlider} unique id.
#' @param value \link{rpgSlider} value.
#' @param session Shiny session object.
#'
#' @rdname rpg-slider
#'
#' @export
updateRpgSlider <- function(inputId, value, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, value)
}




#' Create a button input
#'
#' \link{rpgButton} creates a button input element.
#'
#' @param inputId \link{rpgSlider} unique id.
#' @param label Text writtent on top of the input.
#' @param golden Style parameter. If TRUE, the slider is bordered by fancy elements.
#' FALSE by default.
#'
#' @rdname rpg-button
#' @export
rpgButton <- function(inputId, label, golden = FALSE) {

  value <- restoreInput(id = inputId, default = NULL)

  tags$button(
    class = createElementClass("button", golden),
    id = inputId,
    `data-val` = value,
    type = "button",
    tags$p(label)
  )
}
