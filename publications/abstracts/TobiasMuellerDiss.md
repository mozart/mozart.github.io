---
layout: default
title: "Constraint Propagation in Mozart"
---


2001


Tobias Müller



[PDF](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/TobiasMuellerDiss.pdf)[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/TobiasMuellerDiss.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/TobiasMuellerDiss.bib)



  This thesis presents constraint propagation in
  Mozart which is based on computational agents called propagators.
  The thesis designs, implements, and evaluates propagator-based propagation
  engines.  A propagation engine is split up in generic propagation
  services and domain specific domain solvers which are connected by a
  constraint programming interface. Propagators use filters to perform
  constraint propagation. The interface isolates filters from
  propagators such that they can be shared among various systems.



 This thesis presents the design and implementation of
a finite integer set domain solver for Mozart which reasons over
bound and cardinality approximations of sets. The solver cooperates
with a finite domain solver to improve its propagation and
expressiveness.




This thesis promotes constraints to first-class
citizens and thus, provides extra control over constraints. Novel
programming techniques taking advantage of the first-class status of
constraints are developed and illustrated.





