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
updateRpgSlider <- function(session = shiny::getDefaultReactiveDomain(), inputId, value) {
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



#' Create a checkbox input
#'
#' \link{rpgCheckbox} is a nice checkbox input with RPG design.
#'
#' @inheritParams shiny::checkboxInput
#'
#' @rdname rpg-checkbox
#' @export
rpgCheckbox <- function(inputId, label, value = FALSE, golden = FALSE) {
  value <- restoreInput(id = inputId, default = value)
  HTML(
    sprintf(
    '<input id="%s" class="%s" type="checkbox" checked="%s"><label>%s</label>',
      inputId,
      createElementClass("checkbox", golden),
      value,
      label
    )
  )
}



#' Update a checkbox input
#'
#' \link{updateRpgCheckbox} allows to update a \link{rpgCheckbox} on the server.
#'
#' @inheritParams shiny::updateCheckboxInput
#'
#' @note For now, only the selected value may be updated.
#'
#' @rdname rpg-checkbox
#' @export
updateRpgCheckbox <- shiny::updateCheckboxInput




#' Create a select input
#'
#' \link{rpgSelect} creates a dropdown select input. Whenever size is not NULL,
#' it is displayed as a box.
#'
#' @inheritParams shiny::selectInput
#'
#' @rdname rpg-select
#' @export
rpgSelect <- function(inputId, label, choices, selected = NULL,
                      multiple = FALSE, size = NULL) {
  selectTag <- shiny::selectInput(
    inputId,
    label,
    choices,
    selected,
    multiple,
    selectize = FALSE,
    width = NULL,
    size
  )

  # Modify tag
  selectTag$attribs$class <- NULL
  # Clean extra label class
  selectTag$children[[1]]$attribs$class <- NULL
  # Remove extra outer div
  selectTag$children[[2]] <- selectTag$children[[2]]$children[[1]]

  # Add good class for rppgui binding
  selectTag$children[[2]]$attribs$class <- if (is.null(size)) {
    "rpgui-dropdown"
  } else {
    "rpgui-list"
  }

  selectTag
}



#' Update a select input
#'
#' \link{updateRpgSelect} allows to update a \link{rpgSelect} on the server.
#'
#' @inheritParams shiny::updateSelectInput
#'
#' @note For now, only the selected value may be updated.
#'
#' @rdname rpg-select
#' @export
updateRpgSelect <- shiny::updateSelectInput
