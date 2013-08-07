---
layout: default
title: "Situated Simplification"
---


1997


Andreas Podelski and Gert Smolka



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/SituSimpliTCS.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/SituSimpliTCS.bib)


Testing satisfaction of guards is the essential operation of
concurrent constraint programming (CCP) systems.  We present and
prove correct, for the first time, an incremental algorithm for the
simultaneous tests of entailment and disentailment of rational tree
constraints to be used in CCP systems with deep guards (e.g., AKL or
Oz).  The algorithm is presented as the simplification of the
constraints which form the (possibly deep) guards and which are
  situated at different nodes (or, local computation spaces) in a tree
(of arbitrary depth).  In this algorithm, each variable may have
multiple bindings (representing multiple constraints on the same
variable in different nodes).  These may be realized by re- and
de-installation upon each newly resumed check of the guard in the
corresponding node (as done, e.g., in AKL or Oz), or by using look-up
tables (with entries indexed by the nodes).  We give a simple
fixed-point algorithm and use it for proving that the tests
implemented by another, practical algorithm are correct and complete
for entailment and disentailment.  We formulate the results in this
paper for rational tree constraints; they can be adapted to finite and
feature trees.



Theoretical Computer Science,  v173, 1997



Proceedings of the 1st Conference on Principles and Practice of Constraint
  Programming, Sep 1995, Springer-Verlag




