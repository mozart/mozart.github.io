---
layout: default
title: "Promoting Constraints to First-class Status"
---


2000


Tobias Müller



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/Mueller-00a.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/Mueller-00a.bib)


This paper proposes to promote constraints to first-class status.  In
contrast to constraint propagation, which performs inference on values
of variables, first-class constraints allow reasoning about the
constraints themselves.  This lets the programmer access the current
state of a constraint and control a constraint's behavior directly,
thus making powerful new programming and inference techniques
possible, as the combination of constraint propagation and rewriting
constraints &agrave; la term rewriting.  First-class constraints allow for
true meta constraint programming. Promising applications in the
field of combinatorial optimization include early unsatisfiability
detection, constraint reformulation to improve propagation, garbage
collection of redundant but not yet entailed constraints, and finding
minimal inconsistent subsets of a given set of constraints for
debugging immediately failing constraint programs.



We demonstrate the above-mentioned applications by means of examples.
The experiments were done with Mozart Oz but can be easily ported
to other constraint solvers.




Proceedings of the First International Conference on Computational Logic --
  CL2000, Jul 2000, Springer-Verlag




