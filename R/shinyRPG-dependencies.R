#' shinyRPG dependencies utils
#'
#' @description This function attaches shinyRPG dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools tagList htmlDependency
#' @export
add_shinyRPG_deps <- function(tag) {
 shinyRPG_deps <- htmlDependency(
  name = "shinyRPG",
  version = packageVersion("shinyRPG"),
  src = c(file = "shinyRPG-0.0.0.9000"),
  script = "js/shinyRPG.js",
  package = "shinyRPG",
 )
 tagList(tag, shinyRPG_deps)
}
    
