---
layout: default
title: "A Parallel Abstract Machine for the Thread-Based Concurrent Constraint Language Oz"
---


1997


Konstantin Popov



[Postscript](http://www.ps.uni-sb.de/PapersOz/Others/pamoz.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/pamoz.bib)



A parallel abstract machine for Oz PAMOz is presented in this
paper. Oz is a thread-based concurrent constraint programming language
with state. Oz is convenient for concurrent programming like modelling
multi-agent systems, as well as for solving combinatoric problems.
PAMOz models the execution of a sublanguage of Oz without its
constraint solving facilities. PAMOz has been implemented in the
parallel Oz system, which is derived from the sequential Oz system and
inherits its optimizations. PAMOz is targeted to shared-memory
multiprocessors. PAMOz executes Oz threads in parallel. PAMOz is
derived from AMOz, a sequential abstract machine for Oz.  There
are two principal differences between PAMOz and AMOz: the
architecture of the abstract machine, and the implementation of
operations on stateful data. PAMOz can be conservatively
extended for full Oz; there is an interface between PAMOz and
its constraint solving extension.





