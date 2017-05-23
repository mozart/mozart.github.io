functor 
import
  Connection
  System(show:Show)
  Pickle
define	
  LS	
   try LS={Connection.take {Pickle.load './gsticket' $}}
   catch
    error(url(_ _) debug:_) then {Show 'url or file not found'}
   [] error(connection(_ _)  debug:_)  then {Show connectionfailed}
   end
   NewObj LocalStore Movehere UserId
   try
      {LS newLocal(Module user1  ?UserId ?NewObj ?LocalStore ?Movehere)}
   catch gs(connectionfailed)
   then
      {Show connectionfailed}
   end
   try {Pickle.save {Connection.offerUnlimited LocalStore $} './client1ticket'}
   catch
    error(url(_ _) debug:_) then {Show 'cannot create url or file '}
   [] error(connection(_ _)  debug:_)  then {Show 'connection Module error'}
   end
end

