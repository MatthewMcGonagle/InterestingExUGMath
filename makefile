TEX = main.tex 
_MULTIVARDIFFCALCGRAPHS = hyperbolaFamily hyperbolaEnvelope 
MULTIVARDIFFCALCGRAPHS = $(patsubst %, _generated/%.pdf, $(_MULTIVARDIFFCALCGRAPHS))

_MULTIVARINTCALCPICS = significandProduct uvRegion
MULTIVARINTCALCPICS = $(patsubst %, _generated/%.pdf, $(_MULTIVARINTCALCPICS))

GRAPHS = $(MULTIVARDIFFCALCGRAPHS) $(MULTIVARINTCALCPICS)

define svgToPdf =
_generated/$(2).pdf : $(1)/$(2).svg
	inkscape --file=$(1)/$(2).svg --export-pdf=_generated/$(2).pdf 
endef

main: $(TEX) $(GRAPHS) 
	pdflatex main
	bibtex main
	pdflatex main
	pdflatex main

$(MULTIVARDIFFCALCGRAPHS) : multiVarDiffCalc/graphs.py
	python multiVarDiffCalc/graphs.py

$(foreach pic, $(_MULTIVARINTCALCPICS),\
	$(eval $(call svgToPdf,multiVarIntCalc,$(pic)))\
)

