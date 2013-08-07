---
layout: default
title: "Comparing Trailing and Copying for Constraint Programming"
---


1999


Christian Schulte



[PDF](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/copying.pdf)[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/copying.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/copying.bib)



A central service of a constraint programming
system is search. In almost all constraint
programming systems search is based on trailing,
which is well understood and known to be
efficient.  This paper compares trailing to
copying. Copying offers more expressiveness as
required by parallel and concurrent
systems. However, little is known how trailing
compares to copying as it comes to implementation
effort, runtime efficiency, and memory
requirements. This paper discusses these issues.




Execution speed of a copying-based system is shown
to be competitive with state-of-the-art
trailing-based systems. For the first time, a
detailed analysis and comparison with respect to
memory usage is made.  It is shown how
recomputation decreases memory requirements which
can be prohibitive for large problems with copying
alone. The paper introduces an adaptive
recomputation strategy that is shown to speedup
search while keeping memory consumption low. It is
demonstrated that copying with recomputation
outperforms trailing on large problems with
respect to both space and time.




Proceedings of the Sixteenth International Conference on Logic Programming, Nov
  1999, The MIT Press




