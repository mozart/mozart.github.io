---
layout: default
title: "An Overview of the Design of Distributed Oz"
---


1997


Seif Haridi, Peter Van Roy, and Gert Smolka



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/PASCO97.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/PASCO97.bib)



We present a design for a distributed programming system, Distributed
Oz, that abstracts away the network. This means that all network
operations are invoked implicitly by the system as an incidental
result of using particular language constructs. However, since network
operations are expensive, the programmer must retain control over
network communication patterns. This control is provided through the
language constructs. While retaining their centralized semantics, they
are extended with a distributed semantics. Distributed Oz is an
extension of Oz, a concurrent state-aware language with first-class
procedures. Distributed Oz extends Oz with just two concepts: mobility
control and asynchronous ordered communication. Mobility control
provides for truly mobile objects in a simple and clean
way. Asynchronous ordered communication allows to conveniently build
servers. These two concepts give the programmer a control over network
communications that is both simple and predictable. We give scenarios
to show how common distributed programming tasks can be implemented
efficiently. There are two reasons for the simplicity of Distributed
Oz. First, Oz has a simple formal semantics.  Second, the distributed
extension is built using network protocols that are natural extensions
to the centralized language operations. We discuss the operational
semantics of Oz and Distributed Oz and the architecture of the
distributed implementation. We give an overview of the basic network
protocols for communication and mobility.




Proceedings of the Second International Symposium on Parallel Symbolic
  Computation (PASCO '97), Jul 1997, ACM Press




