# # ui
library(shinyFiles)

navbarPage("monitorgonio",
	tabPanel("load data",
		mainPanel(
			actionButton("quit", "quit"),
			hr(),
			
			fileInput("key", "choose ptt key file:",
				accept = c(".csv"),
				width = "255"
			),
			shinyFilesButton('logpath', 'log file', 'Please select a log file', FALSE),
			textOutput('path')
		)
	),
	tabPanel("monitor",
		fluidPage(
			fluidRow(
				column(4,
					tableOutput("gtab")
				),
				column(8,
					plotOutput("compass")
				)
			)
		)
	)
)
