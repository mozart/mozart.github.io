---
layout: default
title: "Le protocole réparti de Distributed Oz (In French)"
---


1999


Iliès Alouini and Peter Van Roy



[Postscript](http://www.ps.uni-sb.de/PapersOz/Others/alouini98.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/alouini98.bib)



Distributed Oz is a programming language designed for building distributed 
applications. This paper defines a model, called the  distribution 
graph,
for the distributed execution of the language. Within this
model, each category of Oz language entity (stateful, stateless,
and single assignment) is implemented by a protocol that defines its
network behavior.  The model explains how these language entities
interact, and in particular, how distributed operations on one language
entity can result in the creation of new remote references to other
language entities.  We define the protocol for stateless data
(procedures and records) within this model; the other two protocols
have been published previously.  This model is the
foundation of the Mozart programming system, which implements Oz.





