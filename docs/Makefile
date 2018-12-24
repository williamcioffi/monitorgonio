all: index ss

index : index.Rmd
	Rscript --vanilla -e 'rmarkdown::render("index.Rmd")'

ss : ss.Rmd
	Rscript --vanilla -e 'rmarkdown::render("ss.Rmd")'

clean:
	rm -f index.html

