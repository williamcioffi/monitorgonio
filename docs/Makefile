all: index

index : index.Rmd
	Rscript --vanilla -e 'rmarkdown::render("index.Rmd")'

clean:
	rm -f index.html

