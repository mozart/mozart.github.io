---
layout: default
title: "Constructive Disjunction in Oz"
---


1995


Tobias Müller and Jörg Würtz



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/CDinOz.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/CDinOz.bib)


Constraint programming has been proved as an excellent  tool to solve
combinatorial problems in many application areas. Through constraint
propagation  large parts of the search space can be pruned away. Hard problems
are those which involve disjunctive constraints introducing non-determinism.
While the introduction of choice-points for disjunctive constraints may lead
to combinatorial explosion, other approaches only check whether the
disjunction can still be satisfied.  Constructive disjunction instead lifts
common information of alternatives up and thus allows other parts of the
computation to benefit from this extra information. This form of propagation
improves pruning of search spaces for certain classes of problems, such as
scheduling, time tabling and the like, enormously. We present  how to realize
constructive disjunction  for finite domain constraints without  local
computation spaces in  the concurrent constraint language Oz. The
implementation is achieved with minimal effort reusing existing concepts. Our
implementation scheme is suited for other constraint systems based on
arc-consistency algorithms too.



11th Workshop Logische Programmierung, 27--29 Sep 1995, GMD--Forschungszentrum Informationstechnik GmbH, D-53754 Sankt Augustin




