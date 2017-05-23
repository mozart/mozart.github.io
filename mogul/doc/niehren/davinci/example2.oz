%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Example with Actions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Graph-Specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
declare
Graph = [node(
	    'OBJECT':'LA-LA' 
	    edges:[edge(kind:light to:po)
		   edge(kind:heavy to:po)
		   edge(kind:heavy to:dipsy id:'lalaedge')] 
	    id:lala
	    kind:lala) 
	 node(
	    'OBJECT':'PO'
	    id:po
	    kinds:[po round]) 
	 node('OBJECT':'DIPSY'
	      edges:[edge(kind:light to:tinkywinky)]
	      id:dipsy
	      '_GO':ellipse
	      'BORDER':double
	      kinds:[dipsy]) 
	 node(
	    'OBJECT':'TINKYWINKY' 
	    edges:[edge(kind:light to:po)] 
	    id:tinkywinky 
	    kind:tinky)] 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Graph specifications to be added later on %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Subgraph specifications need as their first node
%% the node where they are connected. (You must give at
%% least it's id!)

SubGraph   = [node(id:dipsy
		   edges:[edge(kind:light to: tubbytoast)])
	      node(id:tubbytoast
		   'OBJECT':'TUBBYTOAST'
		   '_GO':rhombus
		   %edges:nil
		  )]

%% Independent new graphs must consist of new nodes and edges
%% i.e. their identities must not be identical with already existing
%% items

ExtraGraph = [node(id: noonoo
		   'OBJECT':'Noo-noo hoover'
		   '_GO' : ellipse
		   'COLOR': lightblue
		   edges:[edge(to:dust)
			  edge(to:dirt)
			  edge('EDGECOLOR': pink to:pudding)])
	      node('OBJECT':'Dirt'
		   id:dirt)
	      node('OBJECT':'Dust'
		   id: dust)
	      node('OBJECT':'Tubby Pudding'
		   id: pudding
		   'COLOR':pink)]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% (Layout)-Parameter- Specification %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Note that you must specify default-values for edge and node
%% layouts, at least they could have unit as value!

%% In order to invoke actions you might create menues at nodes,
%% edges or via icons and edit menu at the window.
%% This is provided by the feature 'm' of {edge, node}-layout specification
%% and 'app_m' or 'icons' of window specification.
%% The value of these features is a list of {menu_entries, icon_entries}.

%% type menu_entry: menu_entry(MenuId MenuLabel)

%% MenuId will normally refer to a procedure that will be executed
%% when the menu entry is chosen. See for the action procedures below
 
%% Nested menus are not implemented.


Parameters=
unit(
   layout:
      unit(
	 edge:unit(default:
		      edge('EDGECOLOR':black
			   'EDGEPATTERN':dashed
			   '_DIR':none
			   'HEAD':farrow
			   m:[menu_entry(RemoveEdge 'Remove')]
			  )
		   light:
		      edge('EDGECOLOR':orange
			   'EDGEPATTERN':dotted
			   '_DIR':normal
			   m:[menu_entry(RemoveEdge 'Remove')
			      menu_entry(InvertLight 'Invert')
			     ]
			  )
		   heavy:
		      edge('EDGECOLOR':blue
			   'EDGEPATTERN':solid
			   '_DIR':inverse
			   m:[menu_entry(RemoveEdge 'Remove')
			      menu_entry(InvertHeavy 'Invert')
			     ]
			  )
		  )
	 node:
	    unit(default:
		    unit('COLOR':white
			 '_GO':text
			 'OBJECT':'no text given'
			 m:[menu_entry(WinkeNode 'Winke(Winke)')
			    menu_entry(RemoveNode 'Remove')
			    menu_entry(RemoveSubgraph 'Remove Subgraph')
			   ]
			)
			       
		 round:unit('_GO':circle)
		 lala:unit('COLOR':yellow)
		 dipsy:unit('COLOR':green)
		 tinky:unit('COLOR':violet)
		 po:unit('COLOR':red)
		)
	 %% Menus (to be found in 'Edit' menu)
	 %% and icons for daVinci window.
	 window:unit(app_m:
			[menu_entry(WinkeMenu 'Tubby Winke Winke')
			 menu_entry(DrawToaster 'Make Tubbytoast')
			 menu_entry(Quit 'Quit Application')
			]
		     %% Icons have to be a (black and white?)
		     %% X-Window Bitmap file (.xbm format)
		     %% of size 18x18 pixel. See dVDocumentation.
		     icons:[icon_entry(WinkeAll
				       './hi.xbm'
				       'Winke Winke')
			    icon_entry(Quit
				       './quit.xbm'
				       'Quit Application')]
		    )
	 )
	 
   % actions can be used to define the procedures that will be
   % executed when edges or nodes are double clicked on
   % type: unit(edgeDoubleClick : Proc
   %            nodeDoubleClick : Proc
   %            edgeSingleClick: Proc
   %            nodeSingleClick: Proc
   %            communication_error: Proc
   %            ok: Proc)
   % other given features will have no effect
   
   actions: unit(edgeDoubleClick :
		    proc{$ EdgeId DaVinci}
		       {DaVinci.change.attribs
			[edge(EdgeId
			      unit('EDGECOLOR':black))
			]}
		    end
		 nodeDoubleClick :
		    proc{$ NodeId DaVinci}
		       {DaVinci.change.attribs
			[node(NodeId
			      unit('COLOR':orange))
			]}
		    end
		 communication_error :
		    proc{$ Parameter DaVinci}
		       {Inspect
			{VirtualString.toAtom "a communication error occurred"}}
		       {Inspect unit(actcom: Parameter.act
				     lastcom: Parameter.last)}
		    end
		 nodeSingleClick:
		    proc{$ NodeId DaVinci}
		       {Browser.browse
			{VirtualString.toAtom
			 'Hi Hi '#NodeId#'!'}}
		    end
		 ok: proc{$ Parameter DaVinci}
			skip
		     end
		)
   
   %% List of atoms. Atoms are daVinci commands of
   %% category 'set' (see dV-Documentation)
   configuration: ['set(font_size(12))'
		   'set(gap_width(6))'
		   'set(gap_height(18))']
   %% if set to true, communication with daVinci will be verbosed
   debugging: true
   )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Action Specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% These are the actions to be executed when a menu entry is
%% chosen. For procedures called at pop-up-menus, two arguments
%% are expected, the first being the ItemId (NodeId or EdgeId),
%% The second argument is the DaVinci-Environment which provides
%% a set of actions on the graph as well as the state of the graph
%% and the current selected edge and node(s).
%% Procedures invoked at the EditMenu and via Icons expect
%% one argument namely the DaVinci-Environment.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


proc{InvertLight EdgeId DaVinci}
   {DaVinci.change.attribs
    [edge(EdgeId
	  unit('_DIR':inverse
	       m:[menu_entry(RemoveEdge 'Remove')
		  menu_entry(InvertHeavy
			     'Invert')]))
    ]}
end

proc{InvertHeavy EdgeId DaVinci}
   {DaVinci.change.attribs
    [edge(EdgeId
	  unit('_DIR':normal
	       m:[menu_entry(RemoveEdge 'Remove')
		  menu_entry(InvertLight
			     'Invert')]))
    ]}
end

% Invert = unit(light:InvertLight
% 	      heavy:InvertHeavy)

proc{RemoveNode NodeId DaVinci}
   {DaVinci.remove.nodes [NodeId]}
end

proc{RemoveEdge EdgeId DaVinci}
   {DaVinci.remove.edges [EdgeId]}
end

proc{RemoveSubgraph NodeId DaVinci}
   {DaVinci.remove.subgraph NodeId}
end

proc{WinkeNode NodeId Davinci}
   {Browser.browse
    {VirtualString.toAtom
     'Winke Winke '#NodeId#'!'}}
end

proc{WinkeMenu _ Davinci}
   for Node in  {DaVinci.selectedNodes} do
      {Browser.browse
       {VirtualString.toAtom
	'Winke Winke '#Node#'!'}}
   end
end

proc{WinkeAll  _ _}
   {Browser.browse 'Winke Winke!'}
end

proc{DrawToaster _ DaVinci}
   {DaVinci.activate.editmenu [WinkeMenu Quit]}
   {DaVinci.activate.icons [Quit]}
   {DaVinci.add.subgraph SubGraph}
end

proc{Quit  _ _}
   {Application.exit 0}
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Execution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

URL = 'x-ozlib://niehren/davinci'
[Interface] = {Link [URL#'/manager.ozf']}

DaVinci = {Interface.make Parameters} 
{DaVinci.newGraph Graph} 
{DaVinci.setTitle 'Actions Example'}
{DaVinci.setSize 550#300}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Using the Draw-Procedure %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
declare
NewParameter =
unit(parameter:
	unit(layout:
		unit(edge:
			unit(default:unit)
		     node:
			unit(default: unit('_GO':circle
					   m:[menu_entry(Sorry 'Remove')]
					  )
			    )
		    )
	     debugging:false)
     actions:TestActions
    )

proc{Sorry NodeId DV}
   {Browse 'Sorry: No implementations provided for:'}
   {Browse NodeId}
end

TestActions =
unit(
   nodeDoubleClick :
      proc{$ NodeId DaVinci}
	 {DaVinci.change.attribs
	  [node(NodeId
		unit('COLOR':green))
	  ]}
      end
   )

%Unquote the following line and execute it for testing

%{DaVinci.draw ExtraGraph NewParameter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Some directly executed actions %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% {DaVinci.add.nodes [node(id:floopy
% 		 'OBJECT':'FLOOPY')]}
			 
% {DaVinci.add.graph ExtraGraph}

% {DaVinci.add.edges [add('from':noonoo
%   			edge: edge(to:tubbytoast))]}


% These calls will show you all information about current nodes and edges
%{Browse {DaVinci.state.nodes.toRecord}} 
%{Browse {DaVinci.state.edges.toRecord}} 


%{Browse {DaVinci.selectedNodes}}
%{Browse {DaVinci.selectedEdge}}

% {DaVinci.memo.put a 'hallo'}
% {Browse {DaVinci.memo.get a}}
% {Browse {DaVinci.memo.entries }}














