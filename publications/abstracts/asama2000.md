---
layout: default
title: "Fault-Tolerant Mobile Agents in Mozart"
---


2000


Iliès Alouini, Peter Van Roy



[Postscript](http://www.ps.uni-sb.de/PapersOz/Others/asama2000.ps.gz)



[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/asama2000.bib)


In any wide-area distributed system such as the Internet, fault
tolerance is crucial for real-world applications.  We describe a new
practical fault-tolerant mobile agent platform. The agent platform is built
on the top of the Mozart system using a "global store" abstraction
that provides a globally coherent and fault tolerant memory. The global
store looks like a set of objects which are accessed using a transactional 
interface.  Instances of the global store are used for two purposes:
to store the agent state and to communicate with the agent. The store is 
lightweight, requires no persistence, and is independent of the file system.  
Processes can be added to or removed from the store dynamically.  With $n$ 
processes, the store tolerates up to $n-1$ fail-stop process failures.
This is adequate for fault tolerance on a LAN; we are working on extending
the store for network partitioning, so that it will be adequate also on the
complete Internet.  The store can migrate without dependencies, i.e., the
migration depends on no fixed process.  Mozart is a general-purpose 
development
platform for open, robust distributed applications that is based on the Oz
language.  A beta version of the global store is implemented completely
within Oz using Mozart's reflective fault model.  The beta version has been
publicly released in the Mozart Global User Library.


