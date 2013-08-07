---
layout: default
title: "A Platform for Constructing Virtual Spaces"
---


1998


Per Brand, Nils Franzen, Erik Klintskog, and Seif Haridi



[Postscript](http://www.ps.uni-sb.de/PapersOz/Others/virtual.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/virtual.bib)



Virtual spaces (worlds) applications are among
the most complex of distributed applications. They
are both distributed and open. Minimizing network
latency, fault-tolerance, persistence, resource
control, and security are also important
aspects. Designing and implementing virtual spaces
is currently difficult in that the already not
insignificant complexities of program
functionality, distribution, openness, and
efficiency are interwound and cannot be tackled
separately.




We present a distributed programming language,
distributed-Oz, that greatly reduces the
complexity of distributed programming by clearly
separating the different aspects of distributed
programming. The design and implementation of
distributed-Oz is ongoing work, but considerable
progress has been made. The current prototype
demonstrates network transparency, that
computations behave the same way regardless of how
the computation is partitioned between different
sites. This is the basis for realizing clean
separation of the functionality aspect from other
aspects. Network awareness allows the programmer
to predict and control network communication
patterns. The current system gives the programmer
the means to tackle separately the aspects of
openness, efficiency (minimizing latency),
distribution, and functionality.




We have extended distributed-Oz with a tool for
graphics in a distributed setting. This extends
the idea of network transparency and network
awareness to graphics. From the programmers point
of view graphics programming for a multi-user
application is virtually the same as programming
for a single-user application. The differences are
necessary extensions for achieving network and
site awareness, such as visualization control
(deciding which users should see what).




Finally we consider virtual space applications,
and propose a number of abstractions for use by
developers of virtual spaces, relating them to the
properties of distributed-Oz upon which they are
based.





