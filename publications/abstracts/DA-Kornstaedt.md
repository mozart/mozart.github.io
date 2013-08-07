---
layout: default
title: "Definition und Implementierung eines
                Front-End-Generators für Oz"
---


1996


Leif Kornstaedt



[Postscript](http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/DA-Kornstaedt.ps.gz)

[BibTeX Entry](http://www.ps.uni-sb.de/PapersOz/abstracts/DA-Kornstaedt.bib)


In der vorliegenden Diplomarbeit wird ein
Front-End-Generator
entwickelt, der die multiparadigmatische Sprache Oz als Zielsprache
verwendet.  Damit wird die Eignung von Oz als Implementierungssprache
für Compiler demonstriert und die Reimplementierung des Oz-Compilers
in Oz vorbereitet.



Das Werkzeug ist besonders auf die Übersetzung vollkompositionaler
Sprachen ausgelegt.  Das bedeutet, daß neben der lexikalischen und
syntaktischen Analyse, bei der über sogenannte Produktionsschemata
auch eigene EBNF-Operatoren definiert werden können, auch die
Reduktion in eine Kernsprache von dem Werkzeug abgedeckt wird.
Um letztere mächtig zu machen und die Implementierung von
Baumtransformationen zu vereinfachen, bei denen keine Konflikte der
Variablennamen auftreten dürfen, wird weiterhin eine automatisch
durchgeführte Bindungsanalyse mit Umbenennung aller gebundenen
Bezeichner von dem Werkzeug angeboten.




