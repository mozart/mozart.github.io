---
layout: default
title: "Futures and By-need synchronization"
---


1998


Michael Mehl, Christian Schulte, Gert Smolka



[Postscript](http://www.ps.uni-sb.de/PapersOz/Others/oz-futures.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/oz-futures.bib)



  We propose a conservative extension of Oz that adds futures and
  by-need synchronization. Futures are read-only views of logic
  variables that make it possible to statically limit the scope in
  which a variable can be constrained. For instance, one can
  express with futures safe streams that cannot be assigned by
  their readers. By-need synchronization makes it possible to
  synchronize a thread on the event that a thread blocks on a
  future. It is used to express dynamic linking and lazy
  functions.
 




