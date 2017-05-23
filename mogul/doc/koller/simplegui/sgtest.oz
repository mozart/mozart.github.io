
functor

import

   SimpleGUI at 'x-ozlib://koller/simplegui/simplegui.ozf'
   Inspector

define

   {SimpleGUI.create

    % value declarations
    [entry(id:label
	   label:'Label')
     entry(id:sem
	   label:'Semantics'
	   type:ozval
	   flags:[editor]
	  )
     entry(id:start
	   label:'Main Event'
	   type:ozval
	  )]

    % Go! action
    proc {$ Values Options}
       {Inspector.inspect go(val:Values opt:Options)}
    end

    % menus
    [menu(label:'Test'
	  entries:[option(id:foo label:'Foo' default:true)

		   filechoice(id:file label:'Choose File' default:nil)

		   action(label:'Test'
			  accelerator:ctrl(t)
			  action:proc {$ X Y}
				    {Inspector.inspect x(X Y)}
				 end)])]

    % global options (here, none)
    unit
   }


end