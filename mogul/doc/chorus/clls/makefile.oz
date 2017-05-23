makefile(%
	 %% contribution
	 provides  : [
		      %% clls format
		      'clls.ozf'
		      %% rich clls format
		      'rclls.ozf'
		      %% constraint graphs
		      'constraint-graph.ozf'
		      %% equalities
		      'equalities.ozf'
                      %% remove redundant literals
                      'redundancy.ozf'
		     ]
	 subdirs   : [
		      %% graphical constraint output with DaVinci
		      'daVinci'
		      %% converter to prolog style theorem prover format
		      %% http://www.cs.miami.edu/~tptp/cgi-bin/TPTP2WWW/
		      'tptp'
		      %% some testing
                      'test'	
		     ]
	 lib:[%% clls format
	      'clls.ozf'
	      %% rich clls format
	      'rclls.ozf'
	      %% constraint graphs
	      'constraint-graph.ozf'
	      %% expand constants
	      'constants.ozf'
	      %% transfirm constraints
	      'equalities.ozf'
              %% remove redundant literals
              'redundancy.ozf'
	      %% implementation
	      'output.ozf'
	      'matrix.ozf'
	      %% default parameter
	      'solver.ozf'
	      'beta.ozf'
	      'history.ozf'
	     ]
	 %% documentation
	 blurb     : 'The constraint language for data structures (CLLS): data structures and graphical output.'
	 info_html : 'The  constraint language for lambda structures (CLLS) is a language of tree descriptions. This package provides data structures and utilities for CLLS. <P>  CLLS Constraints are list of literals; the richer clls-format supports records that contain a constraint with many additional informations. <p> The package provides iterators for constraints (map, forall), and functions to create and manipulate rclls data. It also features graphical output for both formats, based on the professional DaVinci tool for graph drawing. '
	 doc       : ['makefile.oz']
	 %% package properties
	 mogul     :'mogul:/chorus/clls'
	 uri       :'x-ozlib://chorus/clls'
	 author    : [
		      'mogul:/chorus/project'
		     ]
	 version   : '0.9.20'
	 requires  : ['mogul:/niehren/base'
		      'mogul:/niehren/output'
                      'mogul:/smiele/graph'
		      
		      %% graphical output requires further packages
		      %%    'DaVinci V2.1 (see http://www.tzi.de/daVinci)' 
		      %%    'mogul:/duchier/config'
		      %%    'mogul:/niehren/external-process'

		      %% optional packages that are used if installed
		      %% (but require many more subpackages)

		      %% 'mogul:/chorus/solver'
		      %% 'mogul:/chorus/usp-beta'
		     ] 

	 categories: ['nlp' ]
	)





