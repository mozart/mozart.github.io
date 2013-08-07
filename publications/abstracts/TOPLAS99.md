---
layout: default
title: "Efficient Logic Variables for Distributed Computing"
---


1999


Seif Haridi, Peter Van Roy, Per Brand, Michael Mehl, Ralf Scheidhauer, and Gert Smolka



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/TOPLAS99.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/TOPLAS99.bib)



We define a practical algorithm for distributed rational tree
unification and prove its correctness in both the off-line and on-line
cases.  We derive the distributed algorithm from a centralized one,
showing clearly the trade-offs between local and distributed
execution.  The algorithm is used to realize logic variables in the
Mozart Programming System, which implements the Oz language
(see [http://www.mozart-oz.org](http://www.mozart-oz.org/)).
Oz appears to the programmer as
a concurrent object-oriented language with dataflow synchronization.
Logic variables implement the dataflow behavior.  We
show that logic variables can easily be added to the more restricted
models of Java and ML, thus providing an alternative way to do
concurrent programming in these languages.  We present common
distributed programming idioms in a network-transparent way using
logic variables.  We show that in common cases the algorithm maintains
the same message latency as explicit message passing.  In addition, it
is able to handle uncommon cases that arise from the properties of
latency tolerance and third-party independence.  This is evidence that
using logic variables in distributed computing is beneficial at both
the system and language levels.  At the system level, they improve
latency tolerance and third-party independence.  At the language
level, they help make network-transparent distribution practical.




ACM Transactions on Programming Languages and Systems,  n3 v21, 1999




