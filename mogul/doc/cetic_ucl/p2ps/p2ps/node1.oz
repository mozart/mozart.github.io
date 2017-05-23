%% node1 %%
declare
[P2PS] = {Module.link ['x-ozlib://cetic_ucl/p2ps/P2PS.ozf']}
MS

% Create first node (with id 1) in a P2PS network.
% Set the port# in the access point config to 3001.
OP2PS = {New P2PS.p2pServices
	 createNet(nodeConfig: nodeConfig(nodeId:1)
		   apConfig:apConfig(pn:3001)
		   msgStrm:MS)}

% Display each message received on the message stream.
thread
   for M in MS do
      {Show M}
   end
end
