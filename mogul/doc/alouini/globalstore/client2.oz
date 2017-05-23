functor
import
   System(show:Show)    
   OS
   Open
   Connection
   Pickle
   Module
   Application
define 
   class Counter
      attr val
      meth show(Value) Value=@val end
      meth inc(Value) val <- @val+Value end
      meth init(Value) val <- Value end  
   end
   %%% Store emulator pid in a file
   F Pid 
   try
      Pid={OS.getPID}
      F={New Open.file init(name:'/tmp/pidclient'#Pid flags:[write create])}      
      {F write(vs:Pid)}
      {F close}
   catch
      error(_)
   then
   {Show 'ErrorCreateFile'}
   end   
   %%% deamon to simulate site failure
   %{OS.system "deamon" _}
   %%%
   %%%%%%%%%%%%%%%%%%%%%%%%%
   %% Initiate a local store
   %%%%%%%%%%%%%%%%%%%%%%%%%
    LS
   try LS={Connection.take {Pickle.load './client1ticket' $}}
   catch
    error(url(_ _) debug:_) then {Show 'url or file not found'}
   [] error(connection(_ _)  debug:_)  then {Show connectionfailed}
   end   
   LocalStore NewObjInStore Movehere
   try
      {LS newlocal(Module user1  ?NewObjInStore ?LocalStore ?Movehere)}
   catch gs(connectionfailed)
   then
      {Show connectionfailed}
   end
   {Delay 15000}
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Create an object in the store
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   Obj1 Obj2 Obj3 
   Obj3={NewObjInStore  Counter init(0)}
   Obj2={NewObjInStore  Counter init(0)}
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%% Get the local reference of an object
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   try
      {LocalStore getobj('/usr/staff/ila/=Oz/store/o1globalref' ?Obj1)}
   
   catch
      gs(objectlost) then {Show 'object lost'}
   []  error(url(_ _) debug:_) then {Show 'url or file not found'}
   [] error(connection(_ _)  debug:_)  then {Show 'connection Module error'}
   end   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Procedure to show a coherent
   % snapshot of the global store
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   CoherentSnapshot
   proc {CoherentSnapshot}
      C={NewCell 0}
      proc{Trans Output}
	 Val1 Val2 Val3 in
	 {Obj1 show(Val1)} 
	 {Obj2 show(Val2)}
	 {Obj3 show(Val3)}
	 Output=state(Val1 Val2 Val3)
      end
      Trid
      Out
      Res
    in
     % State of objects Obj1 Obj2 is coherent here
     % show  state of  objects in a file after 1mn of period
      if {OS.time  $} - {Access C $}>=20
      then
	 {LocalStore trans(Trans Out ?Trid)}
	 {LocalStore checktrans(Trid Res _)}	 	
	 if Res==commit  then
	       {Show 'Obj1:'#Out.1#'Obj2:'#Out.2#'Obj3:'#Out.3}
	 else
	    skip
	 end	    
	 {Assign C {OS.time  $}}
      else
	 skip
      end
   end   
   %%%%%%%%%%%%%%%%%%%
   % Init transactions 
   %%%%%%%%%%%%%%%%%%%
   Transset Iterate 
   fun  {Iterate I}
      Transid Iteratebis Retransid       
      proc{Trans Out}
	 proc  {Iteratebis J}
	    if J\=0
	    then 
	       {Obj1 inc(1) }
	       {Obj2 inc(~1)}
	       {Iteratebis J-1}     	    
	    else
	       skip
	    end
	 end
      in
	 %{LocalStore waitlocks([Obj1 Obj3])} 
	 %{LocalStore newthread(proc {$} {Show 'newthread'} {Obj1 inc(1)} end)}   
	 {Iteratebis 1}
	 {Obj1 inc(1) }
	 {Obj1 inc(~1) }
	 {Obj1 inc(1) }
	 {Obj1 inc(~1) }
	 {Obj1 inc(1) }
	 {Obj3 inc(1) } 
      end
     Out 
   in
      if I\=0
      then
	 {LocalStore trans(Trans Out Transid)}
	 {Delay 60}
	 Transid#Transid|{Iterate I-1}
      else
	 nil
      end 
   end
   Transset={Iterate 1000}   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %% Compute number of committed/aborted transactions
   %% Wait for the end of transactions and updates ..
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   {Wait {LocalStore termination($)}} %  
   Ccommit={NewCell 0} Cabort={NewCell 0} Crcommit={NewCell 0}
   Crabort={NewCell 0} 
   Crecompute={NewCell 0} Crrecompute={NewCell 0}
   {ForAll Transset 
    proc{$ Pair}
       Tr RTr Res Resb Nb Nbr in
       if Pair\=nil then
	  Pair=Tr#RTr
	  {LocalStore checktrans(Tr Res Nb)}
	  {Assign Crecompute  {Access Crecompute  $}+Nb}  
	  if  Res==commit
	  then
	     {Assign Ccommit {Access Ccommit  $}+1}
	  else
	     {Assign Cabort {Access Cabort $}+1}
	  end
	  if {Access Ccommit  $}+{Access Cabort  $}==1000 then
	     {Show 'Number of local committed transaction:'#{Access Ccommit  $}}
	     {Show 'Number of local aborted transaction:'#{Access Cabort  $}}
	     {Show 'Number of local recomputed transaction:'#{Access Crecompute  $}}
	  else
	     skip
	  end
	  {LocalStore checktrans(RTr Resb Nbr)}
	  {Assign Crrecompute  {Access Crrecompute  $}+Nbr} 
	  if Resb==commit
	  then
	     {Assign Crcommit {Access Crcommit  $}+1}
	  else
	     {Assign Crabort {Access Crabort $}+1}
	     end
	  if {Access Crcommit  $}+{Access Crabort  $}==1000 then
	     {Show 'Number of local aborted retrans :'#{Access Crabort  $}}
	     {Show 'Number of local committed retrans :'#{Access Crcommit  $}}
	     {Show 'Number of local recomputed retrans:'#{Access Crrecompute  $}}
	  else
	     skip
	  end
	  
       else
	  skip
       end
    end
   }   
   {CoherentSnapshot}
end
	
