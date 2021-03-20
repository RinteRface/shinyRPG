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



#' Utility to center elements
#'
#' @param tag Tag on which to apply the class.
#'
#' @return The input tag with modified class.
#' @export
rpgCenter <- function(tag) {
  tag$attribs$class <- paste0(tag$attribs$class, " rpgui-center")
  tag
}

#' Utility to disable elements
#'
#' @param tag Tag on which to apply the attribute.
#'
#' @return The input tag with modified attribute.
#' @export
rpgDisable <- function(tag) {
  tag$attribs$disabled <- NA
  tag
}