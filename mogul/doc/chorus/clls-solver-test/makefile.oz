makefile(%% contribution
	 provides  : [
		      %% tester for Clls solver
		      'tester.ozf'
                      %% run the tester in the OPI
		      'test.oz'
		     ]
         
	 lib:[
	      'tester.ozf'
	      'test.oz'
	     ]
         
	 subdirs : nil
	 
	 %% documentation
	 blurb     : 'Contains a tester for CLLS solvers.'
         doc       : ['makefile.oz']
                          
	 %% package properties
	 uri       :'x-ozlib://chorus/clls/solver-test'
	 mogul     :'mogul:/chorus/clls-solver-test'
	 author    : [
		      'mogul:/chorus/project'
		     ]
	 version   : '0.1.1'
	 requires  : ['mogul:/chorus/clls'
                      'mogul:/niehren/davinci'
		      'mogul:/chorus/solver'
		      %% Solvers for CLLS and its fragments are
		      %% available in Mogul:
		      %%
		      %%   mogul:/chorus/dominance-solver-...
		      %%   mogul:/chorus/clls-solver-ke

                      %% Example constraints can be found in the
                      %% Mogul, too:
                      %%
                      %%   mogul:/chorus/clls-examples
		     ] 

	 categories: ['nlp' 'cp']

         info_html : "The constraint language for lambda structures
(CLLS) is a language of tree descriptions. This package provides a
tester for CLLS solvers. <P> Solvers for CLLS and its fragments are
available in Mogul: <P> mogul:/chorus/dominance-solver-...<P>
mogul:/chorus/clls-solver-ke<P>" )




