TEX = main.tex 
_MULTIVARDIFFCALCGRAPHS = hyperbolaFamily hyperbolaEnvelope 
MULTIVARDIFFCALCGRAPHS = $(patsubst %, _generated/%.pdf, $(_MULTIVARDIFFCALCGRAPHS))

_ONEVARDIFFCALCGRAPHS = graphFoliumDescartes xzGraphFolium nonMercator mercator fermatUpper fermatLower
ONEVARDIFFCALCGRAPHS = $(patsubst %, _generated/%.pdf, $(_ONEVARDIFFCALCGRAPHS))

_MULTIVARINTCALCPICS = significandProduct uvRegion
MULTIVARINTCALCPICS = $(patsubst %, _generated/%.pdf, $(_MULTIVARINTCALCPICS))

_ONEVARDIFFPICS = perspective1 perspective2
ONEVARDIFFPICS = $(patsubst %, _generated/%.pdf, $(_ONEVARDIFFPICS))

_PRECALCPICS = signPoly signTangentLines
PRECALCPICS = $(patsubst %, _generated/%.pdf, $(_PRECALCPICS))

PICS = $(MULTIVARINTCALCPICS) $(ONEVARDIFFPICS) $(PRECALCPICS)
GRAPHS = $(MULTIVARDIFFCALCGRAPHS) $(ONEVARDIFFCALCGRAPHS) 

define svgToPdf =
_generated/$(2).pdf : $(1)/$(2).svg
	inkscape --file=$(1)/$(2).svg --export-pdf=_generated/$(2).pdf 
endef

main: $(TEX) $(GRAPHS) $(PICS) 
	pdflatex main
	bibtex main
	pdflatex main
	pdflatex main

$(MULTIVARDIFFCALCGRAPHS) : multiVarDiffCalc/graphs.py
	python multiVarDiffCalc/graphs.py

_generated/graphFoliumDescartes.pdf _generated/xzGraphFolium.pdf: oneVarIntCalc/foliumDescartes.py
	python oneVarIntCalc/foliumDescartes.py

_generated/nonMercator.pdf _generated/mercator.pdf _generated/fermatLower.pdf _generated/fermatUpper.pdf : oneVarIntCalc/graphs.py
	python oneVarIntCalc/graphs.py

$(foreach pic, $(_MULTIVARINTCALCPICS),\
	$(eval $(call svgToPdf,multiVarIntCalc,$(pic)))\
)

$(foreach pic, $(_ONEVARDIFFPICS),\
	$(eval $(call svgToPdf,oneVarDiffCalc,$(pic)))\
)

$(foreach pic, $(_PRECALCPICS),\
	$(eval $(call svgToPdf,preCalculus,$(pic)))\
)
