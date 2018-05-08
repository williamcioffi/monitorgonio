# monitor a file in real time
# note if a new file is generated int he directory being monitored
# then it is not included in the changedFiles output.

# need to look for changes in the xls tag file
# 	update the key of tags to filter on
# need to look for changes in the log text file
# 	update a plot of where the animal is pointing

# make this a shiny app? might not be able to pop out windows
# show a table of most recent hits on half the screen
# show the plot on the other half of the screen with arrows slowly fading
FILESEP <- .Platform$file.sep

logchoose <- file.choose()
keychoose <- file.choose()

logname <- strsplit(logchoose, FILESEP)[[1]]
pathname <- paste(logname[-length(logname)], collapse = FILESEP)
logname <- logname[length(logname)]

snapshot <- fileSnapshot(pathname, md5sum=TRUE)

i <- 0
while(TRUE) {
	ch <- changedFiles(snapshot)$changes
	if(any(ch[grep(logname, rownames(ch)), ])) {
		snapshot <- fileSnapshot(pathname, md5sum=TRUE)
		cat(i)
		i <- i + 1
		log <- readgonio(logchoose)
	}
}