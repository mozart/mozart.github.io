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

makefile(
   %%contibution
   provides:['interface.ozf']
   requires:['LEDA library']
   
   src     :['mehltest.exe']

   lib     :['interface.ozf'
	     'mehlhorn.so']

   depends : o(
		'mehlhorn.o': ['redundancy.hh'
			       'mehlhorn.cc'
			       'domgraph.cc'
			       'domgraph.hh'
			       'hypernormal_cycle_test.hh'
			      ]
		)
   
   rules   : o(
		'mehlhorn.so': ld('mehlhorn.o'
				  [library('L') library('G')])
		)
   %% documentation
   blurb   : 'Satisfiablity test for normal dominance constraints.'
   doc     : ['makefile.oz']
   
   %% properties
   author  : ['mogul:/duchier/denys'
	      'mogul:/chorus/project']
   version : '1.1.0'
   uri     : 'x-ozlib://chorus/solver/km-interface/'
   mogul   : 'mogul:/chorus/dominance-solver-km-interface'
   )








