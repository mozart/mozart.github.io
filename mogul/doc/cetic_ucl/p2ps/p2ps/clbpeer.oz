functor
import
   Application
   System

   P2PS at 'x-ozlib://cetic_ucl/p2ps/P2PS.ozf'
define
   RefreshTime  = 5*1000 % the time before a node has to anounce its presence
   LifeTime     = 5*60*1000 % node default life time (5*60 sec)
   
   Args     % record with the command arguments
   OP2PS    % an instance of class P2PS.p2pServices
   MmbDict  % a memership dictionary of node ids
   LockDict % lock for MmbDict
   
   % Build a node with node id NId on local port PN .
   proc {MakeNode PN}
      try 
	 OP2PS={New P2PS.p2pServices createNet(apConfig:apConfig(pn:PN))}
	 {System.showInfo 'local node created on port '#
	  {OP2PS getAPConfig($)}.pn}
      catch p2ps(couldNotConfig pn:_) then
	 {System.showInfo '\n~~~ exception: problem with the port:'#PN#'\n'}
	 {Application.exit 0}
      end

      thread {SendAlive} end
   end

   % Join the system via the node with IP and remote port# PN.
   % LPN is the desired local port#
   proc {JoinSys IP PN LPN}
      try
	  Tn = {P2PS.address2ap IP PN}
      in
	 OP2PS={New P2PS.p2pServices
		joinNet(remoteAP:Tn apConfig: apConfig(pn:LPN))}

	 {System.showInfo 'local node created on port '#
	  {OP2PS getAPConfig($)}.pn}
	 {System.showInfo 'my node Id is: '#{OP2PS getNodeConfig($)}.nodeId}
	 
	 {OP2PS broadcast(msg:newnode)}
	 thread {SendAlive} end
      catch _ then
	 {System.showInfo '\n~~~ error: there was an error when joining the system\n'}
	 {Application.exit 0}
      end
   end

   % Broadcast amAlive msg forever.
   proc {SendAlive}
      {Delay RefreshTime}
      
      try
	 {OP2PS broadcast(msg:alive)}
      catch _ then skip end
      
      {SendAlive}
   end

   % Process the input message stream.
   proc {ProcMsgStrm MS}
      for E in MS do
	 case E of rcvMsg(src:NId msg:M dst:_) then
	    case M of newnode then
	       {AddToMmbDict NId}
	    [] alive then
	       {AddToMmbDict NId}  
	    [] leave then
	       {RemFromMmbDict NId unit}   
	    else skip end
	 end
      end
   end

   % Add node Id NId to MmbDict.
   proc {AddToMmbDict NId}
      Vrs
   in
      lock LockDict then
	 if {Dictionary.condGet MmbDict NId nil} \= nil then
	    Vrs = {Dictionary.get MmbDict NId}+1
	    {Dictionary.put MmbDict NId Vrs}
	 else
	    Vrs = 0
	    {Dictionary.put MmbDict NId Vrs}
	    {System.showInfo 'node: '#NId#' added'}
	    {System.show membership#{Dictionary.keys MmbDict}}
	 end
      end
	 
      thread
	 % after RefreshTime plus some delay remove Nid
	 {Delay RefreshTime+5000} 
	 {RemFromMmbDict NId Vrs}
      end
   end

   % Remove node Id NId from MmbDict, if inside and the right version is used.
   proc {RemFromMmbDict NId Vrs}
      E
   in
      lock LockDict then
	 E = {Dictionary.condGet MmbDict NId nil}
	 
	 if E == Vrs then
	    {Dictionary.remove MmbDict NId}
	    {System.showInfo 'node: '#NId#' dropped'}
	    {System.show membership#{Dictionary.keys MmbDict}}
	 elseif Vrs == unit then
	    {Dictionary.remove MmbDict NId}
	    {System.showInfo 'node: '#NId#' left'}
	    {System.show membership#{Dictionary.keys MmbDict}}
	 end
      end
   end

in
   MmbDict = {NewDictionary}
   LockDict = {NewLock}
   
   % specify the application input arguments
   Args = {Application.getCmdArgs
	   record(host(single type:atom default:unit)          % host name
		  lport(single type:int default:_)             % local port
		  rport(single type:int default:unit)          % remote port
		  lifetime(single type:int default:LifeTime))} % node's life time

   if Args.host \= unit then
      if Args.rport \= unit then
	 {JoinSys Args.host Args.rport Args.lport}
	 thread {ProcMsgStrm {OP2PS getMsgStrm($)}} end
      else
	 {System.showInfo '\n~~~ error: provide the remote port: e.g., --rport 3002\n'}
	 {Application.exit 0}
      end
   else
      {MakeNode Args.lport}
      thread {ProcMsgStrm {OP2PS getMsgStrm($)}} end
   end

   thread
      % after a live time leave the sys and close the application
      {Delay Args.lifetime*1000} 

      try
	 {OP2PS broadcast(msg:leave)}
      catch _ then skip end

      {Delay 1000}  % wait some time until msg leave is sent
      {OP2PS leaveNet}
      {Application.exit 0}      
   end
end
