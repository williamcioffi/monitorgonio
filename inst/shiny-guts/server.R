# server

pathname <- vector()
snapshot <- vector()
logname <- vector()
datapath <- vector()
i <- 0

gdat <- NULL

function(input, output, session) {	
	observeEvent(input$quit, {
		stopApp(0)
	})
	
	volumes <- c('file system' = "/")
	shinyFiles::shinyFileChoose(input, 'logpath', roots = volumes, session = session)
	output$path <- renderText({
		getlogpath()
	})
	
	output$compass <- renderPlot({
		plot(0, 0, 
			pch = 16, 
			asp = 1, 
			ylim = c(-1.1, 1.1), xlim = c(-1.1, 1.1), 
			axes = FALSE, xlab = "", ylab = ""
		)
		draw.circle(0, 0, 1)
		alphadegs <- seq(0, 315, by = 45)
		alpharads <- alphadegs * pi / 180

		for(i in 1:length(alpharads)) {
			pt0 <- c(0, 1.1)
			a <- alpharads[i]
			rotm <- matrix(c(cos(a), sin(a), -sin(a), cos(a)), ncol=2)
			
			ptr <- pt0 %*% rotm
			text(ptr[1], ptr[2], as.character(alphadegs[i]))
		}
		
		if(!is.null(getgdat())) {
			gdat5 <- head(getgdat(), 5)
			if(!is.null(gdat5$deployid)) {
				key <- getkey()
				colors <- rainbow(length(key$deployid[!is.na(key$deployid)]), alpha = .6)
				cols <- match(gdat5$deployid, key$deployid)
			} else {
				colors <- rainbow(5, alpha = .6)
				cols <- as.numeric(as.factor(gdat5$hex))
			}
							
			for(i in 1:nrow(gdat5)) {
				draw.radial.line(0, 1, deg = 360 - (gdat$bearing[i] - 90), col = colors[cols[i]], lwd = 20, expand = TRUE)
			}
			draw.radial.line(0, 1, deg = 360 - (gdat$bearing[1] - 90), col = "black", lwd = 5, expand = TRUE)
			draw.circle(0, 0, .4, col = "white")
			text(0, 0.25, as.character(gdat5$bearing[1]), cex = 4)
			text(0, -0.25, as.character(gdat5$strength[1]), cex = 4)
	
			if(!is.null(gdat5$deployid)) text(0, 0, as.character(gdat5$deployid[1]), cex = 4, col = colors[cols[1]])
		}
	}, height = 600, width = 600)
	
	output$gtab <- renderTable({
		if(is.null(getgdat())) return(NULL)
		
		getgdat()
	})
	
	getlogpath <- reactive({
		out <- parseFilePaths(volumes, input$logpath)
		if(length(out) == 0) {
			out <- NULL
		} else {			
			logname <<- as.character(out$name)
			pathname <<- sub(paste0(logname, "$"), "", as.character(out$datapath))
			snapshot <<- fileSnapshot(pathname, md5sum=TRUE)
			
			out <- as.character(out$datapath)
			datapath <<- out
		}
		
		out
	})
	
	getkey <- reactive({
		keyfname <- input$key
		out <- NULL
		if(!is.null(keyfname)) {
			# columns 2 and 3 and hex and deployid
			key <- read.table(keyfname$datapath, sep = ",", header = TRUE, stringsAsFactors = FALSE)
			key <- key[, 2:3]
			names(key) <- c("hex", "deployid")
			out <- key
		}
		
		out
	})
	
	getgdat <- reactive({
		invalidateLater(1000, session)
		
		key <- getkey()
		
		if(length(pathname) != 0) {
			ch <- changedFiles(snapshot)$changes
			if(any(ch[grep(logname, rownames(ch)), ])) {
				snapshot <<- fileSnapshot(pathname, md5sum=TRUE)
				gdattmp <- readgonio(datapath)
				if(!is.null(key)) {
					gdattmp <- merge(gdattmp, key, all.x = FALSE, all.y = FALSE)
					oo <- order(gdattmp$date, decreasing = TRUE)
					gdattmp <- gdattmp[oo, ]
				}
				gdat <<- gdattmp
			}
		}
		
		if(length(gdat) == 0) return(NULL)
		
		gdat
	})
}
