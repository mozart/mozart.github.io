%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this generates procedures for menu entries %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% the exported functions get an argument for the required
%% parameters and return a procedure referring to the
%% action to be executed when the menu entry is chosen
%% this procedure needs two arguments the first one refers
%% to the id of edge or node when the menu is placed at nodes
%% or edges. when the menu is placed at the edit-menu or
%% at an icon this first argument has no relevance
%% the second argument relates to the davinci environment, which
%% provides some graph manipulating actions (cf. index.html)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functor
import
   Inspector(inspect:Inspect)
   Application
export
   Remove
   Hello
   Quit
   Change

define
   fun{Remove Kind}
      case Kind
      of edges then
	 proc{$ Id DaVinci}
	    {DaVinci.remove.Kind [Id]}
	 end
      [] nodes then
	 proc{$ Id DaVinci}
	    {DaVinci.remove.Kind [Id]}
	 end
      [] subgraph then
	 proc{$ Id DaVinci}
	    {DaVinci.remove.Kind Id}
	 end
      [] X then
	 proc{$ _ _}
	    {Inspect error('Msg': 'Wrong Argument'
			   arg: X
			   argsAllowed: [egdes nodes subgraph]
			   'proc': 'Remove'
			   file: 'menu-actions.oz')
	    }
	 end
      end
   end

   fun{Hello Kind}
      case Kind
      of node then
	 proc{$ NodeId Davinci}
	    {Inspector.inspect
	     {VirtualString.toAtom
	      'Hello '#NodeId#'!'}}
	 end
      [] all then
	 proc{$ _ DaVinci}
	    for Node in  {DaVinci.selectedNodes} do
	       {Inspector.inspect
		{VirtualString.toAtom
		 'Hello '#Node#'!'}}
	    end
	 end
      [] none then
	 proc{$  _ _}
	    {Inspector.inspect 'Hello Tubbies!'}
	 end
      [] X then
	 proc{$ _ _}
	    {Inspect error('Msg': 'Wrong Argument'
			   arg: X
			   argsAllowed: [node none all]
			   'proc': 'Hello'
			   file: 'menu-actions.oz')
	    }
	 end

      end
   end

   fun{Quit}
      proc{$  _ _}
	 {Application.exit 0}
      end
   end

   fun{Change Parameter}
      if {Not{HasFeature Parameter kind}} orelse
	 {Not {Member Parameter.kind [node edge]}}
      then
	 proc{$ _ _}
	    {Inspect error('Msg': 'Wrong or incomplete argument'
			   kind: {CondSelect Parameter kind missing}
			   kindsAllowed: [node edge]
			   'proc': 'Change'
			   file: 'menu-actions.oz')
	    }
	 end
      else
	 DefaultPara = unit(changes: nil)
	 Paras = {Adjoin DefaultPara Parameter}
	 unit(kind: Kind
	      changes: Changes)= Paras
      in
	 proc{$ Id DaVinci}
	    {DaVinci.change.attribs
	     [Kind(Id
		   {List.toRecord unit Changes}
		  )
	     ]}
	 end
   
      end
   end
   
     	 
end

      
