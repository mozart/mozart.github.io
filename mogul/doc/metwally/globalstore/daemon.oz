%%% Daemon to simulate site failures
%%% Author:      I.Alouini
%%% Last update: 1-7-00
%%% Deamon launched on each host
%%% /tmp/pidclient????? and  /tmp/pidserver pids of emulators
%%% clients and server must store their pid on a file
%%% UNIX version,  For windows NT need special librairies
functor
import
   OS
   Open
   System
export
define
   class TextFile from Open.file Open.text
   end
   class Counter
      attr c:1      
      meth inc c <- @c +1 end
      meth set c <- 1 end
      meth get(?C) C=@c end
   end
   proc {Infinite C}
      ListPids GetClientsPid File  Count in 
      % wait for 1 mn
      {Delay 1000*60}
      {OS.system "ls /tmp/pidclient* > /tmp/files" _}
      File= {New TextFile init(name:"/tmp/files")}
      proc {GetClientsPid ?ListPids}     
	 case  {File getS($)} of  false then ListPids=nil {File close}
	 elseof S
	 then
	    ListPids=S|{GetClientsPid $}
	 end
      end
      {GetClientsPid ListPids}
      Count={New Counter set}      
      %%%%%%%%%%%%%%%%%%%%%%%%
      %% Kill one local client 
      %%%%%%%%%%%%%%%%%%%%%%%%     
      {ForAll ListPids 
       proc {$ Fname}
       File  in
	  File= {New TextFile init(name:Fname)}	  
	  case  {File getS($)} of  false then{File close}
	  elseof S
	  then     
	     if {Count get($)}==C then
		{System.show 'client:kill -9'#' '#{StringToAtom S} }
		{OS.system "kill -9"#" "#S  _}
		% remove the file
		{OS.system "rm /tmp/pidclient"#S _} 
	     else
		skip
	     end
	     {Count inc}     
	  end
	  
       end
      }
      {Count set}
      %%%%%%%%%%%%%%%%%%%%%%%%
      %% Create a new client
      %%%%%%%%%%%%%%%%%%%%%%%%
      %{OS.system "client1" _}
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %% Kill the server if present at host 
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      local File1 in
      try
	 File1= {New TextFile init(name:'/tmp/pidserver')}      
	 case  {File1 getS($)} of  false then {File1 close}
	 elseof S
	 then
	    {System.show  'server:kill -9'#' '#{StringToAtom S }}
	    {OS.system "kill -9"#" "#S  _}
	 end
      catch 
	 _
      then
	 skip
      end
      end
      if C< {List.length ListPids $} then
	 {Infinite C+1}
      else
	 {Infinite 1}
      end
   end
   {Infinite 1}
end


