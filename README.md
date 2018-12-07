# Interesting Examples in Undergraduate Math

These are notes on interesting examples of mathematics at the undergraduate level. What makes an example interesting
is subjective, but these notes include examples that are considered interesting based on applications, theory,
historical significance, or technicality. Of course, examples can be a mixture of these ideas.

The examples are roughly split across different subject areas that are commonly split as individual classes in
undergraduate education; however, there are examples that require more than one subject, and where to correctly
place them is a bit ambiguous. 

# Building the Notes

## Necessary Software

* **LaTeX**
Does the word processing and typesetting of the documents. The executable `pdflatex` is responsible for
converting `.tex` files into `.pdf` files. Also `bibtex` is used to generate a bibliography for the 
references.
* **Inkscape** 
Converts manually drawn vector graphics files `.svg` into `.pdf` files that can be used by LaTeX. The 
executable for Inkscape will need to be located on your system or user PATH variable. 
* **Python**
Used to create graphs for some of the examples. The executable for python will need to be located on 
your system or user PATH variable. The python files have extension `.py`. 
* **Something to Run `make`**
If you are using `Windows`, then you can use `MinGW`. The executable for `mingw32-make` will need to
be on your system or user PATH variable.

## Instructions

You simply need to run the make file in the main directory. If you are using Windows (and using `MinGW`, then from a terminal
opened to the main directory just run

```
mingw32-make
```

## Description of Build

The notes contains several graphics. Some of these are graphs that are generated with `python` using 
the `matplotlib.pyplot` module. Others are drawings that are originally in the `.svg` format. The notes
are intended to generate a `.pdf` output, so these drawings need to be converted to a `.pdf` format
to be included. This can be done with software such as [Inkscape](https://inkscape.org/). To use Inkscape
from the command line, you will need to make sure your user PATH variable includes the location of the
Inkscape executable.

The generated graphics will be stored in the `_generated/` directory:
