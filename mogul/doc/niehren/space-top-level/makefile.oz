%% provides a function that checks being on top-level
%% or in a deep space

makefile(
   lib:[
	%% checks for top level
	'space.ozf'
	%% an example application
	'test-space.oz'
       ]
   mogul:'mogul:/space-top-level'
   uri  :'x-ozlib://base')
