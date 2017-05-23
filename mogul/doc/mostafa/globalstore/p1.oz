%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a new global store
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import
   GlobalStore  
   Connection
   Pickle
   System(show:Show)
define
   Ls
   try
      {GlobalStore.new ?Ls}
      % pickle LS and offer it to clients
      {Pickle.save {Connection.offerUnlimited Ls $} './gsticket'}
   catch
      gs(failed_globalstore_creation) then
      {Show errorNewStore }     
   [] error(url(_ _) debug:_) then {Show 'cannot create url or file '}
   [] error(connection(_ _)  debug:_)  then {Show 'connection Module error'}
   end
end
