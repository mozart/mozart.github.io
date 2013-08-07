---
layout: default
title: "Mobile Objects in Distributed Oz"
---


1997


Peter Van Roy, Seif Haridi, Per Brand, Gert Smolka, Michael Mehl, and Ralf Scheidhauer



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/TOPLAS97.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/TOPLAS97.bib)



Some of the most difficult questions to answer when designing a
distributed application are related to mobility: what information to
transfer between sites and when and how to transfer
it. Network-transparent distribution, the property that a program's
behavior is independent of how it is partitioned among sites, does not
directly address these questions. Therefore we propose to extend all
language entities with a network behavior that enables efficient
distributed programming by giving the programmer a simple and
predictable control over network communication patterns.  In
particular, we show how to give objects an arbitrary mobility behavior
that is independent of the object's definition. In this way, the
syntax and semantics of objects are the same regardless of whether
they are used as stationary servers, mobile agents, or simply as
caches. These ideas have been implemented in Distributed Oz, a
concurrent object-oriented language that is state aware and has data
flow synchronization. We prove that the implementation of objects in
Distributed Oz is network transparent. To satisfy the predictability
condition, the implementation avoids forwarding chains through
intermediate sites. The implementation is an extension to the publicly
available DFKI Oz 2.0 system.




ACM Transactions on Programming Languages and Systems,  n5 v19, 1997




