functor
import
   Application(getCmdArgs) Connection(gate) Pickle(save)
define
   Args = {Application.getCmdArgs
           record(ticketfile(single type:string optional:false))}
   NewsPort
   local Ticket in
      {New Connection.gate init(NewsPort Ticket) _}
      {Pickle.save Ticket Args.ticketfile}
   end
   {List.forAllTail {Port.new $ NewsPort}
    proc {$ H|T}
       case H of connect(Messages) then Messages=T else skip end
    end}
end