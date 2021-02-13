#' @export
rpgPage <- function(...) {
  add_dependencies(div(class = "rpgui-content", ...), deps = c("rpgui", "shinyRPG"))
}

