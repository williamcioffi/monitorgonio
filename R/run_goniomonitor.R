#' run monitorgonio
#'
#' runs the shiny app monitorgonio
#' @name run_monitorgonio
#' @export
#' @examples
#' run_monitorgonio()

run_monitorgonio  <- function() {
	shinydir <- system.file("shiny-guts", package = "monitorgonio")
	if(shinydir == "") stop("couldn't find shiny app...")

	shiny::runApp(shinydir, display.mode = "normal", launch.browser = TRUE)
}
