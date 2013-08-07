---
layout: default
title: "A Higher-order Module Discipline with Separate Compilation, Dynamic Linking, and Pickling"
---


1998


Denys Duchier, Leif Kornstaedt, Christian Schulte, and Gert Smolka



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/modules-98.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/modules-98.bib)



  We present a higher-order module discipline with
  separate compilation and concurrent dynamic linking.
  Based on first-order modules one can program security
  policies for systems that link modules from untrusted
  locations (e.g., Java).  We introduce a pickling
  operation that writes persistent clones of volatile,
  possibly higher-order data structures on the file
  system.  Our pickling operation respects lexical
  binding.  Our module discipline is based on functors,
  which are annotated functions that are applied to
  modules and return modules.  Pickled computed
  functors can be used interchangeably with compiled
  functors.  In contrast to compiled functors, pickled
  computed functors can carry computed data structures
  with them, which has significant practical
  applications.
 




