makefile(
   lib   : [
	    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    %% main functors for syntax users
	    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    
	    %% the lift syntax in various formats
	    'syntax.ozf'  
	    %% a parser is available
	    'parser.ozf'
	    %% write CFG in BNF-format to file 'cfg.bnf'
	    'make-bnf.ozf'

	    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    %% main functors for syntax devellopers
	    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    
	    %% syntax specification
	    'grammar.ozf' 'lexicon.ozf' 'types.ozf' 'namen.ozf'

	    %% testing
	    'test.oz' 'sentences.ozf'

	    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	    %% implementation
	    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	    'remove-feature.ozf' %% projects away a feature in a UG
	    'TUG.ozf'     %% typed unification grammar
	    'UG.ozf'      %% unification grammar
	    'CFG.ozf'     %% context free grammar and Backus Naur form 
	   ] 
   uri       : 'x-ozlib://lift/syntax/german' 
   mogul     : 'mogul:/niehren/lift/syntax/german' 
   author    : 'mogul:/niehren/joachim'
   version   : '1.0.0'
   provides  :[
	       
               %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               %% model of German in the lift
               %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	       
	       %% the lift syntax in various formats
	       'syntax.ozf'  
	       %% a parser is available
	       'parser.ozf'
	       %% write CFG in BNF-format to file 'cfg.bnf'
	       'make-bnf.ozf'
	       
	       %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	       %% main functors for syntax devellopers
	       %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	       
	       %% syntax specification
	       'grammar.ozf' 'lexicon.ozf' 'types.ozf' 'namen.ozf'
	       
	       %% testing
	       'test.oz' 'sentences.ozf'
	      ]
   requires  :['mogul:/niehren/typed-unif-grammar']

   categories:['nlp']
   %% documentation
   blurb     :'A formal grammar system for a German lift control.'
   doc       : ['makefile.oz']

  )

