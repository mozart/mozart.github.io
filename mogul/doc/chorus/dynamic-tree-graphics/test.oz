declare BASE    = 'x-ozlib://base'
declare CHORUS  = 'x-ozlib://chorus'
declare TREE    = CHORUS   #'/dynamic-tree-graphics'

%% Modules %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare Modules = [
		   TREE #'/manager.ozf'
		   BASE #'/inspector.ozf'
		  ]

declare [Tree Inspector] = {Link Modules}

declare Inspect = Inspector.inspect

declare MenuSpecs = [unit(text  :inspect
			  action:Inspect
			  subentries:[unit(text  :inspect
					   action:Inspect)])
		     unit(text  :browse
			  action:Browse)]
	     
{Tree.configure unit(nodeDoubleClick:Browse
		     nodeMenus      :MenuSpecs
		     lineLength     :10)}

{Inspect Tree}
declare Entry1 = unit(id    :'clls1'
		      title :clls1
		      action:'a quite long line to be broken'
		      mother:unit)

declare Entry2 = unit(id    :'clls2'
		      title :clls2
		      action:new
		      mother:'clls1')

declare Entry3 = unit(id    :'clls3'
		      title :clls3
		      action:new
		      mother:'clls1')

declare Entry4 = unit(id    :'clls4'
		      title :clls4
		      action:new
		      mother:'clls3')

{Tree.put Entry1}{Inspect Entry1}
{Tree.put Entry2}{Inspect Entry2}
{Tree.put Entry3}{Inspect Entry3}
{Tree.put Entry4}{Inspect Entry4}

/*
{Tree.close}
*/


