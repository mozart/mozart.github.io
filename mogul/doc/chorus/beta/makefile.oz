%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% underspecified beta reduction
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
makefile(%
	 provides:[
		   'data-base.ozf'
		  ]
	 requires:[
		   'mogul:/chorus/clls'
		   'mogul:/chorus/usp-beta/jn'
		   'mogul:/chorus/clls-solver-ke'
		   'mogul:/niehren/base'
		   'mogul:/niehren/output'
		  ]
	 lib    :[%% user interface
		  'data-base.ozf'
		  %% implementation
		  'redex.ozf'
		  'reduction.ozf'
		  'output.ozf'
		 ]

	 subdirs:[
		  'ke'
		  'jn' %% new usp-beta reducer, half finished, not working.
		  %%      constraint programming approach
		 ]
	 doc       : ['makefile.oz']
	 %% package properties
	 mogul     :'mogul:/chorus/beta'
	 uri       :'x-ozlib://chorus/beta'
	 author    : ['mogul:/chorus/project']
	 version   : '0.1.0'
	 categories: ['nlp' ]
	)





