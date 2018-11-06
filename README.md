# Interesting Examples in Undergraduate Math

These are notes on interesting examples of mathematics at the undergraduate level. What makes an example interesting
is subjective, but these notes include examples that are considered interesting based on applications, theory,
historical significance, or technicality. Of course, examples can be a mixture of these ideas.

The examples are roughly split across different subject areas that are commonly split as individual classes in
undergraduate education; however, there are examples that require more than one subject, and where to correctly
place them is a bit ambiguous. 

# Building the Notes

The notes contains several graphics. Some of these are graphs that are generated with `python` using 
the `matplotlib.pyplot` module. Others are drawings that are originally in the `.svg` format. The notes
are intended to generate a `.pdf` output, so these drawings need to be converted to a `.pdf` format
to be included. This can be done with software such as [Inkscape](https://inkscape.org/). To use Inkscape
from the command line, you will need to make sure your user PATH variable includes the location of the
Inkscape executable.

A complete build of the notes can be done by running the following from the command line and the main directory
of the notes. The generated graphics will be stored in the `_generated/` directory:

```
python multiVarDiffCalc/graphs.py

inkscape --file=multiVarIntCalc/significandProduct.svg --export-pdf=_generated/significandProduct.pdf
inkscape --file=multiVarIntCalc/uvRegion.svg --export-pdf=_generated/uvRegion.pdf

inkscape --file=oneVarDiffCalc/perspective1.svg --export-pdf=_generated/perspective1.pdf
inkscape --file=oneVarDiffCalc/perspective2.svg --export-pdf=_generated/perspective2.pdf

python oneVarIntCalc/graphs.py
python oneVarIntCalc/foliumDescartes.py

inkscape --file=preCalculus/signPoly.svg --export-pdf=_generated/signPoly.pdf
inkscape --file=preCalculus/signTangentLines.svg --export-pdf=_generated/signTangentLines.pdf

pdflatex main
bibtex main
pdflatex main
pdflatex main
```
