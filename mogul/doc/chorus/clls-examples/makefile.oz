makefile(%% contribution
	 provides  : [
                      %% some dominance constraints
                      'dom-cons.ozf'
                      'embedded-chains-generator.ozf'
		     ]
         
	 lib:[
              'dom-cons.ozf'
              'embedded-chains-generator.ozf'
	     ]
         
	 subdirs : nil
	 
	 %% documentation
	 blurb     : 'Some clls constraints.'
         doc       : ['makefile.oz']
                          
	 %% package properties
	 uri       :'x-ozlib://chorus/clls/examples'
	 mogul     :'mogul:/chorus/clls-examples'
	 author    : [
		      'mogul:/chorus/project'
		     ]
	 version   : '0.0.1'
	 requires  : [
                      'mogul:/chorus/clls'
                     ]

	 categories: ['nlp' 'cp']

         info_html : "The constraint language for lambda structures
(CLLS, mogul:/chorus/clls) is a language of tree descriptions.  This
package provides a collection of clls constraints which are intended
for testing new solvers.  Currently only dominance constraints, a
fragment of clls, are included."

        )
