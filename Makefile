RMDS = $(wildcard *.Rmd)
HTMLS = $(patsubst %.Rmd,%.html,$(wildcard *.Rmd))
GITS = $(patsubst %.Rmd,%.md,$(wildcard *.Rmd))


#all: $(HTMLS)

all: $(GITS)


#%.html: %.Rmd
#	Rscript -e "library(rmarkdown);render('$<')"


%.md: %.Rmd
	Rscript -e "library(rmarkdown);render('$<')"


.PHONY: clean


clean:
	rm -f *.html



