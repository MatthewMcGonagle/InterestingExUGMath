define pdfs
$(patsubst %, _generated/%.pdf, $(1))
endef

MULTIVARDIFFCALC_PY_GRAPHS = $(call pdfs,hyperbolaFamily hyperbolaEnvelope) 
ONEVARDIFFCALC_PY_GRAPHS = $(call pdfs,graphFoliumDescartes xzGraphFolium nonMercator mercator fermatUpper fermatLower)

PY_GRAPHS = $(MULTIVARDIFFCALC_PY_GRAPHS) $(ONEVARDIFFCALC_PY_GRAPHS) 
$(info PY_GRAPHS = $(PY_GRAPHS))

DIRS = multiVarDiffCalc multiVarIntCalc oneVarDiffCalc oneVarIntCalc preCalculus topology
EXAMPLE_TEX = $(foreach dir, $(DIRS), $(wildcard $(dir)/*.tex))
$(info EXAMPLE_TEX = $(EXAMPLE_TEX))

# Parameters
#   Directory
#   Svg File Name (no extension)
# Make sure to put newlines around the rule.
define make_svg_to_pdf_rule

_generated/$(2).pdf : $(1)/$(2).svg
	inkscape --file=$(1)/$(2).svg --export-pdf=_generated/$(2).pdf

endef

# Parameters
#	Directory
define get_svg_names
$(patsubst $(1)/%.svg, %, $(wildcard $(1)/*.svg))
endef

$(info svg_info = $(call get_svg_info,preCalculus))
# Parameters
#	Directory
define make_dir_svg_rules
$(foreach svg_file, $(call get_svg_names,$(1)),$(call make_svg_to_pdf_rule,$(1),$(svg_file)))
endef

SVG_RULES = $(foreach dir, $(DIRS), $(call make_dir_svg_rules,$(dir))) 
$(info SVG_RULES = $(SVG_RULES))

PDF_FROM_SVG = $(foreach dir, $(DIRS), $(foreach name, $(call get_svg_names,$(dir)), _generated/$(name).pdf))
$(info PDF_FROM_SVG = $(PDF_FROM_SVG))

# Make sure that main.pdf is the first rule so that it is the default.

main.pdf: main.tex references.bib $(EXAMPLE_TEX) $(PY_GRAPHS) $(PDF_FROM_SVG) 
	pdflatex main
	bibtex main
	pdflatex main
	pdflatex main

$(eval $(SVG_RULES))

# For now, the python graph rules are just manually entered.

$(MULTIVARDIFFCALC_PY_GRAPHS) : multiVarDiffCalc/graphs.py
	python multiVarDiffCalc/graphs.py

_generated/graphFoliumDescartes.pdf _generated/xzGraphFolium.pdf: oneVarIntCalc/foliumDescartes.py
	python oneVarIntCalc/foliumDescartes.py

_generated/nonMercator.pdf _generated/mercator.pdf _generated/fermatLower.pdf _generated/fermatUpper.pdf : oneVarIntCalc/graphs.py
	python oneVarIntCalc/graphs.py

.PHONY : graphs
graphs: $(PY_GRAPHS) $(PDF_FROM_SVG)
	$(info Graphs up-to-date)
