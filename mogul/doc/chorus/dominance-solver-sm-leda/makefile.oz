%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assumptions:
%%
%%    Suppose that you installed LEDA at some directory, say:
%%        leda_install_dir
%%    and that the required environment variables are set:
%%        export LEDAROOT=leda_install_dir
%%        export LD_LIBRARY_PATH=$LEDA-ROOT
%%
%% Installation:
%% 
%%     You can install this package by calling ozmake
%%     with the following options: 
%%
%%        ozmake -I $LEDAROOT/incl -L $LEDAROOT --freshen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makefile(%%contibution
         provides:[
                   'solver.ozf'
                   'rclls-solver.ozf'
                   'output.ozf'
                  ]
         
         requires:[
                   'LEDA library (tested with version 4.4)'
                   'mogul:/chorus/clls'
                   'mogul:/niehren/base'
                   'mogul:/niehren/output'
                  ]
   
         lib     :[
                   'solver.ozf'
                   'rclls-solver.ozf'
                   'solver.so'
                   'output.ozf'

                   %% measures the core solver on some example
                   %% constraints
                   'Makefile'
                   'measure.cc'
                   'constraint-collection.hh'
                 ]

         depends : o('solver.o': [
                                  'bccs.hh'
                                  'cycles.hh'
                                  'disjointness.hh'
                                  'dom-graph.hh'
                                  'dominance.hh'
                                  'fragment.hh'
                                  'min.hh'
                                  'normal-freeness-test.hh'
                                  'solver.cc'
                                  'solver.hh'
                                  'tree-shape-test.hh'
                                  'vector.hh'
                                  'wccs.hh'
                                  'weakly-normal-freeness-test.hh'
                                  'xmalloc.hh'
                                 ]
                    )
   
         rules   : o('solver.so': ld('solver.o' [library('G') library('L')]))

         %% documentation
         blurb   : "solver for weakly normal dominance constraints, implemented in C++/LEDA"
         doc     : ['makefile.oz']
   
         %% properties
         author     : ['mogul:/chorus/project'
                       'mogul:/smiele/sebastian']
         version    : '0.2.6'
         categories : [nlp]
         uri        : 'x-ozlib://chorus/solver/sm-leda'
         mogul      : 'mogul:/chorus/dominance-solver-sm-leda'

         info_html  :
"This package provides an implementation of the Solver for weakly
normal dominance constraints described in <a
href=\"http://ps.uni-sb.de/Papers/abstracts/wndc.html\">An Efficient
Algorithm for Weakly Normal Dominance Constraints</a>.

<p>See the page <a
href=\"http://ps.uni-sb.de/~smiele/dom-solving/\">Solvers for (Weakly)
Normal Dominance Constraints</a> for information on the installation
and usage of this package.  The page also contains informations on
other solvers and example constraints."
)
