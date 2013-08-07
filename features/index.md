---
layout: default
title: Mozart Features
---

# Feature Overview

The Mozart system provides state-of-the-art support in two areas: open
distributed computing and constraint-based inference. Mozart implements Oz, a
concurrent object-oriented language with dataflow synchronization. Oz combines
concurrent and distributed programming with logical constraint-based inference,
making it a unique choice for developing multi-agent systems. Mozart is an
ideal platform for both general-purpose distributed applications as well as for
hard problems requiring sophisticated optimization and inferencing abilities.
We have developed applications in scheduling and time-tabling, in placement and
configuration, in natural language and knowledge representation, multi-agent
systems and sophisticated collaborative tools.


## Programming

### Object-oriented Programming

Oz is a concurrent object-oriented language. In a first approach, Oz can be
programmed in a very similar way to other such languages, like Java. With
experience gained, programs tend to become simpler, for example, as they use
the powerful concepts of dataflow execution and first-class procedures.
Concurrent Programming Oz is an eminently concurrent language. The Mozart
system implements ultralightweight threads with preemptive fair scheduling. It
easily supports applications with many thousands of threads. Dataflow
synchronization is achieved transparently through logic variables.
Multi-Paradigm Programming Unlike most other programming languages which lock
you into a single programming paradigm, Oz unifies into one simple and coherent
framework the functional, object-oriented, and logic flavors of programming.
This is possible due to the very general and powerful underlying paradigm of
concurrent constraint programming.


--------

# Past features

The following are Mozart 1 features currently missing from or being redeveloped for  Mozart 2



## Inferencing

### Constraint Programming

Oz is a powerful constraint language with logic variables, finite domains,
finite sets, rational trees and record constraints. The system is competitive
in performance with state-of-the-art commercial solutions, but is much more
expressive and flexible, providing first-class computation spaces, programmable
search strategies, a GUI for the interactive exploration of search trees,
parallel search engines exploiting computer networks, and a programming
interface to implement new and efficient constraint systems.

### Logic Programming

Oz goes beyond Horn-clauses to provide a unique and flexible approach to logic
programming. Oz distinguishes between directed and undirected styles of
declarative logic programming. For both, Oz lets you specify a program's
logical semantics separately from its resolution strategy. Powerful tools and
libraries are provided built on the concepts of first-class computation spaces
and determinacy-driven disjunctions. Together with distribution, this makes
Mozart an ideal platform for both intelligent multi-agent systems and parallel
search.




## Distribution

### Open Distributed Computing

The Mozart system is an ideal platform for open distributed computing: it makes
the network completely transparent. The illusion of a common store is extended
across multiple sites and automatically supported by very efficient protocols.
In addition, full control is retained over network communication patterns,
permitting very efficient use of network resources. Furthermore, reliable,
fault tolerant applications can easily be developed.

### Distributed Component-Based Programming

Mozart provides first-class software component specifications (called *functors*)
and software components (called modules). The module system facilitates
application development and deployment. Both component specifications and
components can be transparently referenced through URLs, absolute and relative,
and loaded by need. Flexible security policies are implemented by module
managers.

### Mobile Agents

With its dynamic component technology, open computing support, and
full-featured implementation, Mozart is an ideal platform for serious
programming with mobile agents. A computation can create new computations
dynamically. Computations can roam the shared Mozart space at will. Each site
has full control over what resources it makes available to incoming
computations.

### Separation of Concerns (Aspects)

The Mozart system separates the concerns of application functionality,
distribution structure, fault tolerance, and openness (application
connectivity). The separation is almost perfect for the first two concerns and
quite good for the last two. In the context of aspect-oriented programming,
this can be seen as a "vertical" approach, where a few aspects are treated in
depth, versus the "horizontal" approach of tools like AspectJ, which provide
primitives for handling many aspects. 



## Platform Issues

### Cross-Platform Compatibility

Like Java, Oz is "write once, run everywhere" and provides automatic local and
distributed garbage collection. The Oz virtual machine is portable and known to
run on most flavors of Unix as well as on Windows.

### GUI Programming

The Mozart system comes with an object-oriented library that provides a
high-level well integrated interface to Tcl/Tk. This is supplemented with QTk,
a tool that supports a mixed declarative/procedural approach to user interface
design. This needs only a fraction of the code of standard procedural
approaches and is particularly well-suited for building context-sensitive
interfaces.

### Native Extension Modules

The Mozart system was designed to be easily extended with new native
functionality packaged as DLLs. Comprehensive support is provided for the
convenient creation of DLLs. Thus, the Mozart system is not only aggressively
open, but also an ideal very high-level *glue* language.
