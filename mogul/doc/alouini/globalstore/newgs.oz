%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a new global store
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import
   OS
   Open
   GlobalStore(newStore:NewStore) 
   Application
   Connection
   Pickle
   System(show:Show)
define
   Pid F
   Ls
   %%% Store emulator pid in a file : user by the test failure script 
   try
      Pid={OS.getPID}
      F={New Open.file init(name:'/tmp/pidserver' flags:[write create])}      
      {F write(vs:Pid)}
      {F close}
   catch
      error(_)
   then
      {Show 'ErrorCreateFile'}
   end   
   
   try
      {NewStore ?Ls}
      % pickle LS and offer it to clients
      {Pickle.save {Connection.offerUnlimited Ls $} './gsticket'}
   catch
      gs(failed_globalstore_creation) then
      {Show errorNewStore }{Application.exit 0}      
   [] error(url(_ _) debug:_) then {Show 'cannot create url or file '}
   [] error(connection(_ _)  debug:_)  then {Show 'connection Module error'}
   end
end
