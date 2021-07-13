#' @title Launch the shinyRPG Gallery
#'
#' @description A gallery of all components available in shinyRPG.
#'
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'
#'  shinyRPGDemo()
#'
#' }
shinyRPGDemo <- function() { # nocov start
  shiny::shinyAppDir(
    system.file(
      "examples/gallery",
      package = 'shinyRPG',
      mustWork = TRUE
    )
  )
}
