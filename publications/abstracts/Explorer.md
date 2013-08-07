---
layout: default
title: "Oz Explorer: A Visual Constraint Programming Tool"
---


1997


Christian Schulte



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/Explorer.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/Explorer.bib)



This paper describes the Oz Explorer and its implementation. The
Explorer is a visual constraint programming tool intended to support the
development of constraint programs.  It uses the search tree of a
constraint problem as its central metaphor. Exploration and
visualization of the search tree are user-driven and interactive.  The
constraints of any node in the tree are available first-class:
predefined or user-defined procedures can be used to display or analyze
them. The Explorer is a fast and memory efficient tool intended for the
development of real-world constraint programs.




The Explorer is implemented in Oz using first-class computation spaces.
There is no fixed search strategy in Oz. Instead, first-class
computation spaces allow to program search engines. The Explorer is
one particular example of a user-guided search engine. The use of
recomputation to trade space for time makes it possible to solve large
real-world problems, which would use too much memory otherwise.




Proceedings of the Fourteenth International Conference on Logic Programming,
  Jul 1997, The MIT Press




