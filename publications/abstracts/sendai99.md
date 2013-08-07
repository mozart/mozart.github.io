---
layout: default
title: "On the separation of concerns in distributed programming: Application to distribution structure and fault tolerance in Mozart"
---


1999


Peter Van Roy



[Postscript](http://www.ps.uni-sb.de/PapersOz/Others/sendai99.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/sendai99.bib)


Writing distributed applications is difficult
because the programmer has to explicitly juggle
many quite different concerns, including
application functionality, distribution structure,
fault tolerance, security, open computing, and others.
An important goal is to separate the application
functionality from the other concerns.
This article presents one step towards that goal.
We show how to integrate mutable pointers
into a design that separates functionality,
distribution structure, and fault tolerance.
Mutable pointers, as a realization of explicit state,
are an important data type that forms
the basis for object-oriented programming.
We start by defining mutable pointers
in a centralized fault-free system.
We then refine this definition by
successively adding a distribution model and a failure model.
The resulting semantics can be implemented
efficiently and is a sufficient base
to build nontrivial abstractions for fault tolerance.
The design presented here is fully
implemented as part of the Mozart Programming System
(see http://www.mozart-oz.org).


