#' @export
rpgPage <- function(...) {
  add_dependencies(div(class = "rpgui-content", ...), deps = c("rpgui", "shinyRPG"))
}



#' Beautiful container
#'
#' Container to include RPG elements inside.
#'
#' @param ... Ui elements.
#' @param style Style. NULL by default. Valid choices are framed, framed-golden,
#' framed-golden-2 and framed-grey. See \link{validRpgStyles}.
#'
#' @export
rpgContainer <- function(..., style = NULL) {
  if (!is.null(style)) validateRpgStyle(style)

  tags$div(
    class = paste("rpgui-container", if (!is.null(style)) style),
    ...
  )
}
