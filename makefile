TEX = main.tex 
_MULTIVARDIFFCALCGRAPHS = hyperbolaFamily hyperbolaEnvelope 
MULTIVARDIFFCALCGRAPHS = $(patsubst %, _generated/%.pdf, $(_MULTIVARDIFFCALCGRAPHS))

_ONEVARDIFFCALCGRAPHS = graphFoliumDescartes xzGraphFolium nonMercator mercator fermatUpper fermatLower
ONEVARDIFFCALCGRAPHS = $(patsubst %, _generated/%.pdf, $(_ONEVARDIFFCALCGRAPHS))

GRAPHS = $(MULTIVARDIFFCALCGRAPHS) $(ONEVARDIFFCALCGRAPHS) 

DIRS = multiVarDiffCalc multiVarIntCalc oneVarDiffCalc oneVarIntCalc preCalculus 

define _FROMSVG = 
$(eval _NAMES := $(wildcard $(1)/*.svg))\
$(patsubst $(1)/%.svg, _generated/%.pdf, $(_NAMES)) 
endef

define FROMSVG = 
$(foreach dir, $(DIRS), $(call _FROMSVG,$(dir)))
endef 
$(info FROMSVG = $(FROMSVG))

define svgToPdf =
_generated/$(2).pdf : $(1)/$(2).svg
	inkscape --file=$(1)/$(2).svg --export-pdf=_generated/$(2).pdf
endef

# Need to use double $$ for variables that will be evaluated after expansion.
# Note the need to eval each result in the for loop, as a for loop when simply
# expanded doesn't generate new rules.

define dirSvgToPdf =
_SVGFILES := $(wildcard $(1)/*.svg)
SVGFILES := $$(patsubst $(1)/%.svg, %, $$(_SVGFILES))
$$(foreach name, $$(SVGFILES), $$(eval $$(call svgToPdf,$(1),$$(name)))\
)
endef

main: $(TEX) $(GRAPHS) $(FROMSVG) 
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

$(eval $(call dirSvgToPdf,multiVarIntCalc))
$(eval $(call dirSvgToPdf,oneVarDiffCalc))
$(eval $(call dirSvgToPdf,preCalculus))
