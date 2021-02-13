#' rpgui dependencies utils
#'
#' @description This function attaches rpgui. dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom htmltools tagList htmlDependency
#' @export
add_rpgui_deps <- function(tag) {
 rpgui_deps <- htmlDependency(
  name = "rpgui",
  version = "1.0.3",
  src = c(file = "rpgui-1.0.3"),
  script = "js/rpgui.min.js",
  stylesheet = "css/rpgui.min.css",
  package = "shinyRPG",
 )
 tagList(tag, rpgui_deps)
}
    
