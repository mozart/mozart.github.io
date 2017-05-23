declare Modules = [
		   'x-ozlib://base/space.ozf'
		  ]
declare [Space] = {Link Modules}
declare proc{Pred X}
	   X = {Space.isTopLevel}
	end
{Explorer.one Pred}
{Browse {Pred}}


