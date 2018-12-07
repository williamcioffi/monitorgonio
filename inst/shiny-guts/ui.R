# ui

navbarPage("monitorgonio",
	tabPanel("load data",
		mainPanel(
			actionButton("quit", "quit"),
			hr(),
			
			fileInput("key", "choose ptt key file:",
				accept = c(".csv"),
				width = "255"
			),
			h5("choose a log file:"),
			shinyFilesButton('logpath', 'log file', 'Please select a log file', FALSE),
			textOutput('path'),
			
			hr(),
			p("use the buttons above to load the ptt key file and log file. the ptt key file must be a .csv right now. column 2 should be the hex code for the tag and column 3 should be the deployid. if this file gets updated during the day, just use this button to reload it and everything should update automatically on the monitor tab."),
			p("load the log file just once after starting the goniometer logging function and any new receptions of tags will be automatically updated on the monitor tab. tags (hex codes) not present in the ptt key will be ignored. if not ptt key file is loaded, then all goniometer receptions are displayed in the monitor tab.")
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
