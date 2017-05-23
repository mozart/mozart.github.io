%% the inspector in mozart-1.2.1 cannot inspect
%% within spaces. This modul
%%
%%   x-ozlib://base/inspector.oz
%%
%% in this package provides a replacement for the
%% original inspector that indeed inspects on top
%% level and browses in spaces. 

makefile(
   lib:[
	%% inspects on top level and browses in spaces
	'inspector.ozf'
	%% checks for top level
	'space.ozf'
	%% an example application
	'test-space.oz'
       ]
   mogul:'mogul:/base-space'
   uri:'x-ozlib://base')
