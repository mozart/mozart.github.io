makefile(%
	 %% contribution
	 lib    :[
		  %% solver for constraints in clls format
		  'solver.ozf'
		  %% solver for constraints in rich clls format
		  'rclls-solver.ozf'
		  %% test file
		  'test.oz'
		  %% implementation
		  'internal.ozf'
		 ]
	 %% documenation
	 blurb     : 'A solver for dominance constraints.'
	 info_html : 'This package provides a solver for dominance constraints which was first implemented by Denys Duchier.  <P> Dominance constraints are tree descriptions that can talk about the ancestor relation in a tree. The prime application of dominance constraints is scope underspeification in natural language. The present implementation is based on finite set constraints and disjunctive propagators.'
	 doc       : ['makefile.oz']
	 %% package properties
	 uri       : 'x-ozlib://chorus/solver/dd' 
	 mogul     : 'mogul:/chorus/solver/dd'
	 author    : [
		      'mogul:/niehren/joachim'
		      'mogul:/denys/duchier'
		      ]
	 version   : '1.0.0' 
	 requires  : [
		      'mogul:/chorus/clls'
		      'mogul:/chorus/rclls'
		      'mogul:/niehren/base'
		      'FS' 'FD'
		     ]
	 provides  : ['solver.ozf'
		      'rclls-solver.ozf'
		      'test.oz' ]
	 categories: ['nlp' ]
   )



