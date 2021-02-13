#' @export
#' @importFrom shiny tagList
rpgSlider <- function(inputId, label, min, max, value, golden = FALSE) {
  tagList(
    tags$label(label),
    tags$input(
      class = if (golden) "rpgui-slider golden" else "rpgui-slider",
      id = inputId,
      type = "range",
      min = min,
      max = max,
      value = value
    )
  )
}



#' Title
#'
#' @param inputId
#' @param value
#' @param session
#'
#' @return
#' @export
#'
#' @examples
updateRpgSlider <- function(inputId, value, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, value)
}
