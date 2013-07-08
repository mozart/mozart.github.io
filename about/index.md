---
layout: default
title: Mozart Programming System
---

# Mozart Programming System

The Mozart Programming System combines research in programming language design
and implementation, constraint logic programming, distributed computing, and 
human-computer interfaces.

Mozart provides expressive power and advanced functionality. Its 64-bit
implementation supports modern architectures and provides both compiled and
REPL interpreter execution for incremental development and experimentation.



# Mozart 2 Alpha

We are happy to announce the release of Mozart 2, and invite you to give it a
try. The new release has a new 64 bit virtual machine and reflective
language-extension layer. This will be used for future language research and
teaching at UCL.

## Backwards-compatibility

While the language in the main is unchanged, the *constraint* and *distribution*
subsystems of Mozart 1 are not present in Mozart 2, so programs using them will
not work. While distribution and constraints will be added to Mozart 2, they 
will not be the same systems as those of Mozart 1, and backwards compatibility
is not guaranteed.
