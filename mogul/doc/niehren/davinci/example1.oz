%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% GENERAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is an interface for the graph-drawing tool DaVinci.
% The interface enables you to specify graphs and
% let them be drawn by the tool DaVinci.
% DaVinci itself needs a less user-friendly format
% to draw graphs, the translation is done by the interface.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EXAMPLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% You must specify a graph.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Graph-Specification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
declare
Graph = [node(
	    'OBJECT':'LA-LA' 
	    edges:[edge(kind:light to:po)
		   edge(kind:heavy to:po)
		   edge(kind:heavy to:dipsy id:'1')] 
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


% Type graph: list(node)
% Type node: record

% the features of the node's record specify the layout of the node and
% the edges, which are connected to the node

% the id-Feature serves for identification, you can use it for example for
% giving the destination for an edge

% the 'OBJECT'- Feature specifies the text, that will appear inside a node

% the edges-Feature specifies the edges from the node, its value is a list

% there are other features which specify the layout of a node or edge,
% you can specify them directly, but sometimes it is more convenient to
% combine several features : this is done by the feature kind (type:atom)
% or kinds (type: list(atom)),

%% These kinds and the defaults are defined in the layout parameters.

%% The parameters are used by the DaVinci interface
%% in order to determine the attributes of nodes and
%% edges to be drawn by DaVinci.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Layout-Parameter- Specification %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Parameters=
unit(
   layout:
      unit(
	 edge:unit(default:
		      edge('EDGECOLOR':black
			   'EDGEPATTERN':dashed
			   '_DIR':none
			   'HEAD':farrow
			  )
		   light:
		      edge('EDGECOLOR':orange
			   'EDGEPATTERN':dotted
			   '_DIR':normal
			  )
		   heavy:
		      edge('EDGECOLOR':blue
			   'EDGEPATTERN':solid
			   '_DIR':inverse
			  )
		  )
		     
		 
	 node:unit(default:unit('COLOR':white
				'_GO':text
				'OBJECT':'no text given'
			       )
			       
		   round:unit('_GO':circle)
		   lala:unit('COLOR':yellow)
		   dipsy:unit('COLOR':green)
		   tinky:unit('COLOR':violet)
		   po:unit('COLOR':red)
		  )
	 )
     
   )


%% Features left unspecified in the specification of the
%% graph to be drawn are set to
%% Layout.parameters.Kind.Feature, or to
%% Layout.parameters.default.Feature if no value is found
%% for Feature in Kind. Features that are still unspecified
%% get daVinci default values (see dVDocumentation).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Execution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Invoke the manager-functor
[Interface] = {Link ['x-ozlib://niehren/davinci/manager.ozf']}

% The Variable DaVinci is bound to a record which has a feature
% newGraph, the value of this feature is a procedure which takes
% the description of a graph and then causes DaVinci to draw this graph

% The Layout-Parameters are handed to the procedure make which returns
% a record with features newGraph, gi (graphic-interface) and others
DaVinci = {Interface.make Parameters}

% newGraph gets a graph-specification and causes DaVinci to draw this graph 
{DaVinci.newGraph Graph}

% Through gi you can set the title for the DaVinci-Window
{DaVinci.gi.setTitle 'Little Example'}						  
 



