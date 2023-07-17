# global

FILESEP <- .Platform$file.sep

# monitor functions

readgonio <- function(gfile) {
  g <- readLines(gfile)
  g_nprf <- g[grep("NPRF", g)]
  g_npr <- g[grep("NPR,", g)]
  
  # make new files out of these greped vectors
  if(length(g_nprf) != 0) {
    nprf_file <- tempfile()
    writeLines(g_nprf, nprf_file)
    nprf <- read.csv(nprf_file, header = FALSE, sep = ',')
  }
  
  if(length(g_npr) != 0) {
    npr_file <- tempfile()	
    writeLines(g_npr, npr_file)
    npr <- read.csv(npr_file, header = FALSE, sep = ',')
    # add dummy columns for the saved average strength and average bearing columns for NPR (this only works on NPRF)
    npr_withcols <- data.frame(npr[, 1:6], rep(NA, nrow(npr)), npr[, 7:11], rep(NA, nrow(npr)), rep(NA, nrow(npr)), npr[, 12], rep(NA, nrow(npr)), npr[, 13:ncol(npr)])
    names(npr_withcols) <- paste0("V", 1:20)
  }
  
  
  # make a new data table with both NPR and NPRF and the columns lining up
  allg <- rbind(
    if(exists("npr_withcols")) npr_withcols,
    if(exists("nprf")) nprf
  )
  
  if(length(allg) > 0) {
    # remove excess words from recieved date time
    rec_date <- as.character(allg$V1)
    rec_date_split <- strsplit(rec_date, split = " ")
    rec_date_formatted <- sapply(rec_date_split, function(l) paste(l[1], l[2]))
    
    allg$V1 <- rec_date_formatted
    names(allg)[c(1, 9, 12, 15)] <- c("date", "hex", "bearing", "strength")
    oo <- order(allg$date, decreasing = TRUE)
    
    allg <- allg[oo, c(1, 9, 12, 15)]
  }
  
  allg
}
