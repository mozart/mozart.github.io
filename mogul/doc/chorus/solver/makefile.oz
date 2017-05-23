makefile(provides:[
		   'data-base.ozf'
		   'configuration.ozf'
		  ]
	 lib:[
	      'data-base.ozf'
	      'output.ozf'
	      'solver.ozf'
	      'type.ozf'
	      'explorer.ozf'
	      'configuration.ozf'
	     ]
	 requires:[
		   %% clls solver
		   'mogul:/chorus/clls-solver-ke'
		   'mogul:/chorus/dominance-solver-dd'
	%	   'mogul:/chorus/dominance-solver-km-leda'
		   'mogul:/chorus/dominance-solver-sm'  
	%	   'mogul:/chorus/dominance-solver-sm-leda'  
	%	   'mogul:/chorus/dominance-solver-st'  
	%	   'mogul:/chorus/dominance-solver-st-leda'  
		   %% base
		   'mogul:/niehren/base'
		   'mogul:/niehren/output'		  ]
	 subdirs:
	    [
	     jn
	     %% Joachim Niehren's solver for dominance
	     %% constraints
	    ]
	 doc    :['makefile.oz']
	 author :'mogul:/chorus/project'
	 mogul  :'mogul:/chorus/solver' 
	 uri    :'x-ozlib://chorus/solver'
	 version:'0.1.0'
	)

%% km  has become an independent contribution
%% Kurt Mehlhorn's graph algorithm for
%% normal dominace constraints

%% dd has become an independent contribution
%% Denys Duchier's solver for dominance
%% constraints
	    
%% ke has become an independent contribution
%% Katrin Erk's saturation based algorithm
%% for whole CLLS

%% sm is an independed contribution
%% Sebastian Miele's solver for weakly normal dominance
%% constraints with set operators

%% st is an independed contribution
%% Sven Thiel's solver for normal dominance constraints
