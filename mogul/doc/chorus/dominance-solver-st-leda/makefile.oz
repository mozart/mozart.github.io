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
                                  'dom-graph.hh'
                                  'dominance.hh'
                                  'hypernormal-cycle-test.hh'
                                  'redundancy.hh'
                                  'solver.cc'
                                  'solver.hh'
                                 ])
   
         rules   : o('solver.so': ld('solver.o' [library('G') library('L')]))

         %% documentation
         blurb   : "graph based solver and satisfiability test for normal dominance constraints"
         doc     : ['makefile.oz']
   
         %% properties
         author  : ['mogul:/chorus/project']
         version : '0.1.3'
         uri     : 'x-ozlib://chorus/solver/st-leda'
         mogul   : 'mogul:/chorus/dominance-solver-st-leda'

         info_html:
"This package provides an implementation of a Solver for normal
dominance constraints developed and implemented but not yet
published by <a href=\"http://www.mpi-sb.mpg.de/~sthiel>Sven Thiel</a>.

<p>See the page <a
href=\"http://ps.uni-sb.de/~smiele/dom-solving/\">Solvers for (Weakly)
Normal Dominance Constraints</a> for information on the installation
and usage of this package.  The page also contains informations on
other solvers and example constraints."
        )

