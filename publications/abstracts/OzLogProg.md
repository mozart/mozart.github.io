---
layout: default
title: "Logic programming in the context of multiparadigm programming: the Oz experience"
---


2003


Peter Van Roy, Per Brand, Denys Duchier, Seif Haridi, Martin Henz, and Christian Schulte



[Postscript](ftp://ftp.ps.uni-sb.de/pub/papers/Others/OzLogProg.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOld/abstracts/OzLogProg.bib)



Oz is a multiparadigm language that supports logic
programming as one of its major paradigms. A multiparadigm 
language is designed to support different programming paradigms
(logic, functional, constraint, object-oriented, sequential,
concurrent, etc.) with equal ease. This article has two 
goals: to give a tutorial of logic programming in Oz and to 
show how logic programming fits naturally into the wider 
context of multiparadigm programming. Our experience shows 
that there are two classes of problems, which we call 
algorithmic and search problems, for which logic programming 
can help formulate practical solutions. Algorithmic problems 
have known efficient algorithms. Search problems do not have 
known efficient algorithms but can be solved with search. The 
Oz support for logic programming targets these two problem 
classes specifically, using the concepts needed for each. 
This is in contrast to the Prolog approach, which targets 
both classes with one set of concepts, which results in less 
than optimal support for each class. We give examples that 
can be run interactively on the Mozart system, which 
implements Oz. To explain the essential difference between 
algorithmic and search programs, we define the Oz execution 
model. This model subsumes both concurrent logic programming 
(committed-choice-style) and search-based logic programming 
(Prolog-style). Furthermore, as consequences of its 
multiparadigm nature, the model supports new abilities such 
as first-class top levels, deep guards, active objects, and 
sophisticated control of the search process. Instead of Horn 
clause syntax, Oz has a simple, fully compositional, 
higher-order syntax that accommodates the abilities of the 
language. We give a brief history of Oz that traces the 
development of its main ideas and we summarize the lessons 
learned from this work. Finally, we give many entry points 
into the Oz literature.





