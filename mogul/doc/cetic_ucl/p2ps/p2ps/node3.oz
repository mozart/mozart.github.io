declare /* node3 */
[P2PS] = {Module.link ['x-ozlib://cetic_ucl/p2ps/P2PS.ozf']}

% Build the access point token of a node (here, node2) in the P2PS network.
RAP = {P2PS.address2ap "127.0.0.1" 3002}

% Create a node and join the network, using the token RAP.
OP2PS = {New P2PS.p2pServices joinNet(remoteAP: RAP)}

% Send a message to the responsible of key 42.
{OP2PS send(dst:42 msg:sasa toResp:true)}
	 
% Send a multicast message to nodes with id 1 and 16.
{OP2PS multicast(dst:[1 16] msg:hello)}
