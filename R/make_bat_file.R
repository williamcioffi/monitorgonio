#' .bat shortcut for monitorgonio
#' 
#' automatically generates a .bat which should load monitorgonio successfully on windows
#' @param outfile where to save the .bat file
#' @export

make_bat_file <- function(outfile) {
  if(missing(outfile)) stop("gotta tell me where to put the .bat file...")

  rpath <- file.path(R.home("bin"), "Rscript.exe --vanilla")
  runfilepath <- shinydir <- system.file("shiny-guts", package = "monitorgonio")
  if(shinydir == "") stop("couldn't find shiny app...")
  
  runfile <- file.path(runfilepath, "run.R")
  
  command <- paste0("\"", rpath, "\"", " ", runfile)
  cat(command, file = outfile)
}

