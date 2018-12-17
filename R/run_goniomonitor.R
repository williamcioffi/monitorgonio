#' run monitorgonio
#'
#' runs the shiny app monitorgonio
#' @name run_monitorgonio
#' @importFrom shiny runApp
#' @importFrom shinyFiles shinyFileChoose
#' @importFrom plotrix draw.circle
#' @importFrom plotrix draw.radial.line
#' @export
#' @examples
#' \dontrun{
#' run_monitorgonio()
#' }

run_monitorgonio  <- function() {
	shinydir <- system.file("shiny-guts", package = "monitorgonio")
	if(shinydir == "") stop("couldn't find shiny app...")

	shiny::runApp(shinydir, display.mode = "normal", launch.browser = TRUE)
}

