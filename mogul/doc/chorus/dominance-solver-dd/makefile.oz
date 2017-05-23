makefile(%
	 %% contribution
	 provides  : ['solver.ozf'
		      'rclls-solver.ozf'
		      'test.oz' ]
	 lib    :[
		  %% solver for constraints in clls format
		  'solver.ozf'
		  %% solver for constraints in rich clls format
		  'rclls-solver.ozf'
		  %% test file
		  'test.oz'
		  %% implementation
		  'internal.ozf'
		  'output.ozf'
		 ]
	 %% documenation
	 blurb     : 'A solver for dominance constraints.'
	 info_html : 'This package provides a solver for dominance constraints.  <P> Dominance constraints are tree descriptions that can talk about the ancestor relation in a tree. The prime application of dominance constraints is scope underspecification in natural language. <P> The present implementation is based on finite set constraints and disjunctive propagators. It was first implemented by Denys Duchier and then adapted by members of the Chorus-Project. Other solver for dominance constraints or the more general constraint language of lambda structures (CLLS) are available too (mogul:/chorus/clls-solver-ke).'
	 doc       : ['makefile.oz']
	 %% package properties
	 uri       : 'x-ozlib://chorus/solver/dd' 
	 mogul     : 'mogul:/chorus/dominance-solver-dd'
	 author    : [
		      'mogul:/chorus/project'
		      'mogul:/niehren/joachim'
		      'mogul:/duchier/denys'
		      ]
	 version   : '1.3.1' 
	 requires  : [
		      'mogul:/chorus/clls'
		      'mogul:/niehren/base'
		      'mogul:/niehren/output'
		      
		      %% graphical output requires further packages
		      %%    'DaVinci V2.1 (see http://www.tzi.de/daVinci)' 
		      %%    'mogul:/duchier/config'
		      %%    'mogul:/niehren/external-process'
		      
		     ]
	 categories: ['nlp' ]
   )





