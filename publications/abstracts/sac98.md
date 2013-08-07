---
layout: default
title: "Off-Line Scheduling of a Real-Time System"
---


1998


Klaus Schild and Jörg Würtz



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/sac98.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/sac98.bib)



The paper shows how a recently introduced class of applications can be
solved by constraint programming.  This new type of application is due
to the emergence of
special real-time systems, enjoying increasing popularity in such
diverse areas as automotive electronics and aerospace industry.  These
real-time systems are time triggered in the sense that their overall
behavior is globally controlled by a recurring clock tick.  For this
off-line scheduling problem a potentially indefinite,
periodic processing has to be mapped onto a single time window of a
fixed length.  We make this new class
of applications amenable to constraint programming.  We describe
which traditional scheduling and real-time computing
techniques led to success and which failed when confronted with a
large-scale application of this type.  Global constraints were used to
reduce memory consumption and to speed up computation. An elaborate
heuristic, borrowed from Operations Research, was employed to
solve the problem. Furthermore, we show that mere serialization
is sufficient to find a valid schedule.
The actual implementation was done in the concurrent constraint
programming language Oz.




Proceedings of the 1998 ACM Symposium on Applied Computing, SAC98,  1998, ACM
  Press




