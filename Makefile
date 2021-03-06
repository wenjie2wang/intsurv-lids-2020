Rmd_src := cox-cure-net.Rmd
tex_src := intsurv-pkg.tex
bib_src := $(patsubst %.Rmd,%.bib,$(Rmd_src))

Rmd_out := $(patsubst %.Rmd,%.tex,$(Rmd_src))
tex_out := $(patsubst %.tex,%.pdf,$(tex_src))

all: $(tex_out)

$(Rmd_out): $(Rmd_src) $(bib_src)
	@Rscript -e "rmarkdown::render('$<')"

$(tex_out): $(tex_src) $(Rmd_out)
	@latexmk -halt-on-error -pdf $<
	@latexmk -c

clean:
	@$(RM) -rf $(tex_out) $(Rmd_out) *~ .*~ .\#* \
	.Rhistory *.aux *.bbl *.blg *.dvi *.out *.log \
	*.toc *.fff *.fdb_latexmk *.fls *.ttt *diff* *oldtmp* \
	.blb *.synctex.gz

cleanCache:
	@$(RM) -rf $(patsubst %.Rmd,%_cache,$(Rmd_src)) \
		$(patsubst %.Rmd,%_files,$(Rmd_src))
