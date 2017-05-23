%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Example with Actions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This example shows how to device menu entries at
%% nodes, edges, edit menu or icons
%% sometimes it is possible to declare menu entries and
%% the corresponding actions directly in the graph description
%% (see example2.oz)

%% however in other cases it might be more convenient to
%% employ functors which generate the menus and actions

%% this example invokes two functors, one that generates
%% the menus and another that generates the procedures
%% which are part of the menu entries

%% import functors for menu and action -generation %%%%%%%%%%%%%%%%%%%

declare DaVinciLib = 'x-ozlib://niehren/davinci'
declare [Menus Actions] = {Module.link
			   [DaVinciLib#'/example3/menus.ozf'
			    DaVinciLib#'/example3/menu-actions.ozf']}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Graph-Specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
declare
Graph = [node(
	    'OBJECT':'LA-LA' 
	    edges:[edge(to:po)
		   edge(to:po)
		   edge(to:dipsy id:'lalaedge'
		       )] 
	    id:lala
	    kind:lala) 
	 node(
	    'OBJECT':'PO'
	    id:po
	    kinds:[po round]) 
	 node('OBJECT':'DIPSY'
	      edges:[edge(to:tinkywinky)]
	      id:dipsy
	      '_GO':ellipse
	      'BORDER':double
	      kinds:[dipsy]) 
	 node(
	    'OBJECT':'TINKYWINKY' 
	    edges:[edge(to:po)] 
	    id:tinkywinky 
	    kind:tinky)] 



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
			   'EDGEPATTERN':thick
			   '_DIR':none
			   'HEAD':farrow
			   m: [{Menus.remove edges}]
			  )
		  )
	 node:
	    unit(default:
		    unit('COLOR':white
			 '_GO':text
			 'OBJECT':'no text given'
			 m:[{Menus.hello unit(kind:node)}
			    {Menus.remove nodes}
			    {Menus.remove subgraph}
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
			[{Menus.hello unit(kind : none)}
			 {Menus.quit unit}
			]
		     %% Icons have to be a (black and white?)
		     %% X-Window Bitmap file (.xbm format)
		     %% of size 18x18 pixel. See dVDocumentation.
		     icons:[{Menus.hello unit(icon: './hi.xbm'
					      kind: all)}
			    {Menus.quit unit(icon:  './quit.xbm')}
			   ]
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
		    {Actions.change unit(kind:edge
					 changes: ['EDGECOLOR'#blue]
					)
		    }
		 nodeDoubleClick :
		    {Actions.change unit(kind:node
					 changes: ['COLOR'#orange
						  '_GO'#circle])}
		)
   
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Create DaVinci   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare [Interface] = {Link [DaVinciLib#'/manager.ozf']}
declare DaVinci = {Interface.make Parameters} 

{DaVinci.newGraph Graph} 
{DaVinci.setTitle 'Actions Example'}
{DaVinci.setSize 550#300}














