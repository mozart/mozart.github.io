functor
import
   Application(getCmdArgs) Pickle(load) Connection(take)
   Viewer(chatWindow) at 'chat-gui.ozf'
define
   Args = {Application.getCmdArgs
           record(url(single type:string optional:false)
                  name(single type:string optional:false)
                 )}
   NewsPort={Connection.take {Pickle.load Args.url}}
   SelfPort
   thread
      {ForAll {Port.send NewsPort connect($)}
       proc {$ Msg} {Port.send SelfPort Msg} end}
   end
   Chat = {New Viewer.chatWindow init(SelfPort)}
   NAME = Args.name
   {ForAll {Port.new $ SelfPort}
    proc {$ Msg}
       case Msg of msg(FROM TEXT) then
          {Chat show(FROM#':\t'#TEXT)}
       elseof say(TEXT) then
          {Port.send NewsPort msg(NAME {ByteString.make TEXT})}
       else skip end
    end}
end