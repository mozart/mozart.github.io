%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  You need to install LEDA as explained in the
%%  KM-Solver-Interface packages.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makefile(%%contibution
	 requires:['LEDA library'
		   'mogul:/chorus/dominance-solver-km-interface'
		   'mogul:/chorus/clls']
   
	 lib     :['solver.ozf' 
		   'rclls-solver.ozf']

	 %% documentation
	 blurb   : 'Satisfiablity test for normal dominance constraints.'
	 doc     : ['makefile.oz']
   
	 %% properties
	 author  : ['mogul:/chorus/project']
	 version : '0.9.0'
	 uri     : 'x-ozlib://chorus/solver/km'
	 mogul   : 'mogul:/chorus/dominance-solver-km'
	)

