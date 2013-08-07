---
layout: default
title: "The Limits of Network Transparency in a Distributed Programming Language"
---


2007


Rapha&euml;l Collet



[PhD thesis](http://www.info.ucl.ac.be/~raph/papers/thesis.pdf)


[BibTeX Entry](http://www.mozart-oz.org/papers/abstracts/ColletThesis.bib)



*Doctoral Dissertation, December 2007, Universit&eacute; catholique de Louvain*




This dissertation presents a study on the extent and limits of network
transparency in distributed programming languages.  This property states
that the result of a distributed program is the same as if it were executed on
a single computer, in the case when no failure occurs.  The programming
language may also be network aware if it allows the programmer to
control how a program is distributed and how it behaves on the network.  Both
aim at simplifying distributed programming, by making non-functional aspects of
a program more modular.




We show that network transparency is not only possible, but also
practical: it can be efficient, and smoothly extended in the case of
partial failure.  We give a proof of concept with the programming language Oz
and the system Mozart, of which we have reimplemented the distribution support
on top of the [Distribution Subsystem (DSS)](http://dss.sics.se).
We have extended the language to control which distribution algorithms are used
in a program, and reflect partial failures in the language.  Both extensions
allow to handle non-functional aspects of a program without breaking the
property of network transparency.





