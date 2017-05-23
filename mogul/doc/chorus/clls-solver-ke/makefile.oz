makefile(%
	 lib:[%
	      %% solver for constraints in clls format
	      'solver.ozf'
	      %% solver for constraints in rich clls format
	      'rclls-solver.ozf'
	      %% implementation
	      'variable.ozf'
	      'constraint.ozf'
	      'parallelism.ozf'
	      'group-parallelism.ozf'
	      'utilities.ozf'
	      'internal.ozf'
	      'output.ozf'
	      %% example
	      'test.oz'
	     ]
	 provides:['solver.ozf' 'rclls-solver.ozf']
	 %% documentation
	 blurb     : 'A semi decision procedure for CLLS.'
	 info_html : 'This package provides a solver for the constraint language for lambda structures. It was first implemented by Kartin Erk and Sebastian Pado.  <P> The present implementation is based on non-deterministic saturation. Saturation is implemented from scratch.'
	 doc       : ['makefile.oz']
	 %% package properties
	 uri       : 'x-ozlib://chorus/solver/ke' 
	 mogul     : 'mogul:/chorus/clls-solver-ke'
	 author    : [
		      'mogul:/chorus/project'
		     ]
	 version   : '0.6.4' 
	 requires  : [
		      'mogul:/chorus/clls'
		      'mogul:/niehren/base'
		      'mogul:/niehren/output'
		      'mogul:/niehren/inspector-space'
		     ]
	 categories: ['nlp' ]
	)




