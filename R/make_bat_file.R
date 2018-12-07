#' .bat shortcut for monitorgonio
#' 
#' automatically generates a .bat which should load monitorgonio successfully on windows
#' @param ouputdir where to save the .bat file
#' @export

make_bat_file <- function(outfile = "~/Desktop/monitorgonio.bat") {
  rpath <- file.path(R.home("bin"), "Rscript.exe")
  runfilepath <- shinydir <- system.file("shiny-guts", package = "monitorgonio")
  if(shinydir == "") stop("couldn't find shiny app...")
  
  runfile <- file.path(runfilepath, "run.R")
  
  command <- paste0("\"", rpath, "\"", " ", runfile)
  cat(command, file = outfile)
}