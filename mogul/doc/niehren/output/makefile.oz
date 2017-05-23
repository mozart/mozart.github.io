makefile(
   %% package content
   lib       : [%% main
		'output.ozf'
	       ]
   %% package properties
   uri       : 'x-ozlib://base' 
   mogul     : 'mogul:/niehren/output'
   author    : ['mogul:/niehren/joachim' ]
   version   : '0.3.1' 
   requires  : ['mogul:/niehren/base'
		'mogul:/niehren/inspector-space' ]
   categories: ['lib']
   %% documentation
   doc       : ['makefile.oz']
   blurb     : 'Configurable output devices'
   info_html : 'Every application should distinguish at least two output devices: standard and error. In addition a third output device for warning might be useful for many application. <p> This package exports a function New that creates three new output devices called inspect (this is the standard), warning and error. These deviced can changed by applying the configure function that is also created when calling New.'
   )



