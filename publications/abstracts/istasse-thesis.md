---
layout: default
title: "An Oz Implementation Using Truffle and Graal"
---


2017


Maxime Istasse



[PDF](http://www.info.ucl.ac.be/~pvr/MemoireMaximeIstasse.pdf)


We discuss and improve Mozart-Graal, an experimental implementation of the Oz language on the Truffle language implementation framework. It allows Oz to benefit from the Graal JIT compiler and is seen as an opportunity to achieve an efficient implementation with lower maintenance requirements than Mozart 1 and Mozart 2. We propose a mapping for the key Oz concepts on Truffle. We take advantage of the static analysis to make the implementation garbage collection-friendly and to avoid extra indirections for variables. The dataflow variables, calls, tail call optimization, unification and equality testing are implemented in a JIT compiler-friendly manner. Threads are however mapped to coroutines. We finally evaluate those decisions and the quality of the obtained optimizations and compare the performance achieved by Mozart-Graal with Mozart 1 and Mozart 2.

