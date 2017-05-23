%% node 2 %%
declare
[P2PS] = {Module.link ['x-ozlib://cetic_ucl/p2ps/P2PS.ozf']}
MS 

% Build the access point token of a node (node1) in the P2PS network.
RAP = {P2PS.address2ap "127.0.0.1" 3001}

% Create a node with id 16 and join the network, using the token RAP.
OP2PS = {New P2PS.p2pServices
	 joinNet(remoteAP:   RAP
		 nodeConfig: nodeConfig(nodeId:16)
		 apConfig:apConfig(pn:3002))}

% Get the message stream and display each received messages.
thread
   for M in {OP2PS getMsgStrm($)} do
      {Show M}
   end
end
