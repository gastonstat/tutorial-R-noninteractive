RMDS = $(wildcard *.Rmd)
HTMLS = $(patsubst %.Rmd,%.html,$(wildcard *.Rmd))


all: $(HTMLS)


%.html: %.Rmd
	Rscript -e "library(rmarkdown);render('$<')"


.PHONY: clean


clean:
	rm -f *.html



