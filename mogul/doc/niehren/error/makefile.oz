%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This packages defines an alternative to error handling with
%%
%%          raise ... end
%%
%% A function Raise is exported that inspects an exception
%% by an independent Oz process before raising it as usual. 
%%
%% This solves the problem that one often wants to 
%% inspect an exception while also terminating the
%% program execution. 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makefile(%% Contribution
	 lib   : [%% main functor
		  'error.ozf' % E(raise:value -> ...)
		 ]
	 src   : [%
		  'index.html'
		 ]
	 subdirs:[
		  'error'
		 ]
	 %%% Package properties
	 uri       : 'x-ozlib://niehren' 
	 mogul     : 'mogul:/niehren/error'
	 author    : 'mogul:/niehren/joachim'
	 version   : '0.3.2' 
	 requires  : ['DaVinci V2.1 (see http://www.tzi.de/daVinci)' 
		      'mogul:/duchier/config'
		      'mogul:/niehren/base'
		      'mogul:/niehren/external-process'
		     ]
	 provides  : ['error.ozf']
	 categories: ['lib']
	 %% Documentation
	 blurb     : 'Alternative error handling.'
	 info_html : 'This package is no more supported. The implementation is based on remote managers which mostly work only in local area networks.'
	 doc       : ['makefile.oz']
	)



