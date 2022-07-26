MAIN := main
IMGS := \
	build/img/herb_uj.pdf \
	img/bench-dedicated-model-compress.tex \
	img/bench-known-sequencing-compress.tex \
	img/bench-small-data-compress.tex \
	img/bench-best-performance-compress.tex \
	img/bench-dedicated-model-decompress.tex \
	img/bench-known-sequencing-decompress.tex \
	img/bench-small-data-decompress.tex \
	img/bench-best-performance-decompress.tex \
	img/binning.tex \
	img/idn_file.tex
CHAPTERS := \
	conclusion.tex \
	evaluation.tex \
	implementation.tex \
	introduction.tex \
	problem.tex \
	apx-benchmark-env.tex \
	apx-idn-format.tex \
	apx-model-format.tex \
	apx-models.tex \
	apx-test-data.tex
REST := bibliography.bib abstract.tex titlepage.tex
BIBLIOGRAPHY := build/bibliography.bbl
CC := pdflatex -shell-escape
INKSCAPE := inkscape
LINT := lacheck
BIBTEX := bibtex

all: stage2

stage2: $(MAIN).tex $(BIBLIOGRAPHY) $(REST) $(IMGS) $(CHAPTERS)
	$(CC) -output-directory build $<
	$(CC) -output-directory build $<

stage1: $(MAIN).tex $(REST) $(IMGS) $(CHAPTERS)
	mkdir -p build/build
	$(CC) -output-directory build $<

build/img/%.pdf: img/%.svg
	mkdir -p build/img
	$(INKSCAPE) -o $@ $<

$(BIBLIOGRAPHY): stage1
	$(BIBTEX) build/$(MAIN).aux

lint:
	$(LINT) $(MAIN).tex

clean:
	rm -rf build/* *.aux *.log *.bbl *.out *.pdf *.blg *.toc

.PHONY: clean lint
