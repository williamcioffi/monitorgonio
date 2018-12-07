#' .sh shortcut for monitorgonio
#' 
#' automatically generates a .sh which should load monitorgonio successfully on mac / linux
#' @param outfile where to save the .sh file
#' @export

make_sh_file <- function(outfile = "~/Desktop/monitorgonio.sh") {
  rpath <- file.path(R.home("bin"), "Rscript --vanilla")
  runfilepath <- shinydir <- system.file("shiny-guts", package = "monitorgonio")
  if(shinydir == "") stop("couldn't find shiny app...")
  
  runfile <- file.path(runfilepath, "run.R")
  
  header <- "#!/bin/sh"
  command <- paste0(rpath, " ", runfile)
  cat(header, command, file = outfile, sep = "\n")
  
  if(file.exists(outfile))
    system(paste0("chmod 755 ", outfile))
}
