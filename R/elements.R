#' Create a progress bar
#'
#' \link{rpgProgress} creates a simple progress bar.
#'
#' @param id Progress unique id. Necessary to use \link{updateRpgProgress}.
#' @param value Progress value between 0 and 100.
#' @param color Progress color. Valid colors are red, blue, green or purple. Defaults to
#' purple.
#'
#' @rdname rpg-progress
#' @export
rpgProgress <- function(id, value, color = "purple") {
  validateRpgColor(color)
  if (value < 0) stop("value must be >= 0!")

  cl <- sprintf("rpgui-progress %s", color)

  progressConfig <- shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = value / 100,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  tags$div(
    id = id,
    class = cl,
    progressConfig
  )
}



#' Update progress on the server
#'
#' \link{updateRpgProgress} changes the progress bar configuration from the server.
#'
#' @param id \link{rpgSlider} unique id.
#' @param value New value.
#' @param color New color.
#' @param session Shiny session object.
#'
#' @rdname rpg-progress
updateRpgProgress <- function(id, value = NULL, color = NULL, session = shiny::getDefaultReactiveDomain()) {
  options <- dropNulls(list(id = id, value = value, color = color))
  session$sendCustomMessage("update-progress", options)
}
