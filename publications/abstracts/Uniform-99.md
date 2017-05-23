---
layout: default
title: "Uniform Confluence in Concurrent Computation (Unabridged)"
---


1999


Joachim Niehren



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/Uniform:99.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/Uniform:99.bib)


This is the long version of 
Uniform:2000


Indeterminism is typical for concurrent computation. If
several concurrent actors compete for the same resource then 
at most one of them may succeed, whereby the choice of the 
successful actor is indeterministic. As a consequence, the 
execution of a concurrent program may be nonconfluent. Even 
worse, most observables (termination, computational result,
and time complexity) typically depend on the scheduling of 
actors created during program execution. This property 
contrast concurrent programs from purely functional programs.
A functional program is uniformly confluent in the sense 
that all its possible executions coincide modulo reordering 
of execution steps. In this paper, we investigate 
concurrent programs that are uniformly confluent and
their relation to eager and lazy functional programs.



We study uniform confluence in concurrent computation 
within the applicative core of the -calculus
which is 
widely used in different models of concurrent 
programming (with interleaving semantics). In particular,
the applicative 
core of the -calculus serves as a kernel in 
foundations of concurrent constraint programming with 
first-class procedures (as provided by the programming 
language Oz). We model eager functional programming
in the -calculus with weak
call-by-value reduction
and lazy functional programming in the call-by-need 
amming
in the -calculus with standard
reduction. As a measure of 
time complexity, we count application steps. We encode the 
-calculus with both above
reduction strategies 
into the applicative core of the
-calculus and show that
time complexity is preserved. Our correctness proofs employs
a new technique based on uniform confluence and simulations. 
The strength of our technique is illustrated by proving a 
folk theorem, namely that the call-by-need 
complexity of a functional program is smaller than its call-by-value 
complexity. 







