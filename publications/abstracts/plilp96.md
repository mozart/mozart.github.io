---
layout: default
title: "Integrating Efficient Records into Concurrent Constraint Programming"
---


1996


Peter Van Roy, Michael Mehl, and Ralf Scheidhauer



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/plilp96.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/plilp96.bib)



We show how to implement efficient records in constraint logic
programming (CLP) and its generalization concurrent constraint
programming (CCP).  Records can be naturally integrated into CCP as a
new constraint domain.  The implementation provides the added
expressive power of concurrency and fine-grained constraints over
records, yet does not pay for this expressivity when it is not used.
In addition to traditional record operations, our implementation
allows to compute with partially-known records.  This fine granularity
is useful for natural-language and knowledge-representation
applications.  The paper describes the implementation of records in
the DFKI Oz system.  Oz is a higher-order CCP language with
encapsulated search.  We show that the efficiency of records in CCP is
competitive with modern Prolog implementation technology and that our
implementation provides improved performance for natural-language
applications.




International Symposium on Programming Languages, Implementations, Logics, and
  Programs, Sep 1996, Springer-Verlag




