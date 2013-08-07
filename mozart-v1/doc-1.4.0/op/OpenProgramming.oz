%%%
%%% Chapter: Data Structures
%%%

%%
%% Strings
%%

declare
S="C@l!3E4aN#61!"

{Browse {String.toAtom {Filter S Char.isAlpha}}}

{Browse {Filter S Char.isAlpha}}


%%
%% Virtual Strings
%%

{Browse 12#(2#fast#4#"U")#~3.1415}

{Browse {VirtualString.changeSign 12#(2#fast#4#"U")#~3.1415 '~'}}



%%%
%%% Chapter: Files
%%%

%%
%% Reading a file
%%

%% The following five lines produce the file, you will need to
%% try the subsequent examples. Feed them on the OPI:
%% Afterwards it becomes clear what they do.
local
   F={New Open.file init(name:  'a.txt'
                         flags: [write create truncate])}
in
   {F write(vs:"HelloHelloOz is beautiful")}
   {F close}
end
%% Stop feeding here!

declare
F={New Open.file init(name:'a.txt' flags:[read])}

{F read(list:{Browse} size:5)}

{F read(list:{Browse} size:all)}

{F seek(whence:set offset:7)}
{F read(list:{Browse} size:5)}

{F tell(offset:{Browse})}

{F close}


%%
%% Writing a file
%%

declare
F={New Open.file 
       init(name:  'ours.txt'
            flags: [write create]
            mode:  mode(owner: [read write] 
                        group: [read write]))}

{F write(vs:'Go ahead!')}

{F write(vs:"Go ahead!")}

{F write(vs:"This is "#1#' And '#
            ("now a float: "#2.0)#"\n")}

{F close}


%%
%% Exceptions
%%

try
   _={New Open.file init(name:'not-existing')}
catch system(os(A W I S) ...) then
   {Browse os(category:    A
              what:        W
              number:      I
              description: S)}
end


%%
%% Example: Expanding TAB Characters
%%

declare
local
   fun {Insert N Is}
      if N>0 then {Insert N-1 & |Is} else Is end
   end
   fun {Scan Is Tab N}
      case Is of nil then nil
      [] I|Ir then
         case I 
         of &\t then M=Tab-(N mod Tab) in {Insert M {Scan Ir Tab M+N}}
         [] &\n then I|{Scan Ir Tab 0}
         [] &\b then I|{Scan Ir Tab {Max 0 N-1}}
         else I|{Scan Ir Tab N+1}
         end
      end
   end
in
   proc {Expand Tab IN ON}
      IF={New Open.file init(name:IN)} 
      OF={New Open.file init(name:ON flags:[write create truncate])}
      Is
   in
      {IF read(list:Is size:all)}    {IF close}
      {OF write(vs:{Scan Is Tab 0})} {OF close}
   end
end




%%%
%%% Chapter: Input and Output of Text
%%%

%%
%% Expanding TAB Characters Revisited
%%

declare
local 
   fun {Insert N Is}
      if N>0 then {Insert N-1 & |Is} else Is end
   end
   fun {ScanLine Is Tab N}
      case Is of nil then nil
      [] I|Ir then
         case I 
         of &\t then M=Tab-(N mod Tab) in {Insert M {ScanLine Ir Tab M+N}}
         [] &\b then I|{ScanLine Ir Tab {Max 0 N-1}}
         else I|{ScanLine Ir Tab N+1}
         end
      end
   end
   proc {Scan Tab IF OF}
      Is={IF getS($)} 
   in
      if Is==false then 
         {IF close} {OF close}
      else
         {OF putS({ScanLine Is Tab 0})}
         {Scan Tab IF OF}
      end
   end
   class TextFile 
      from Open.file Open.text 
   end
in
   proc {Expand Tab IN ON}
      {Scan Tab 
       {New TextFile init(name:IN)}
       {New TextFile init(name:  ON 
                          flags: [write create truncate])}}
   end
end





%%%
%%% Chapter: Sockets
%%%

%%
%% Stream Sockets
%%


%% Initiating a Connection
declare
Server = {New Open.socket init}

{Server bind(port:{Browse})}

{Server listen}

declare H P in
{Browse H#": "#P}
{Server accept(host:H port:P)}

declare
Client = {New Open.socket init}

%% 
%% YOU HAVE TO ENTER THE PORT NUMBER: OurPort
%%
declare
OurPort = ????
{Client connect(host:localhost port:OurPort)}


%% Exchanging Data
{Server read(list:{Browse})}

{Client write(vs:'Hello, good'#" old Server!")}


%% Disconnecting
{Server close}
{Client close}



%%
%% Accepting Multiple Connections
%%

declare
S={New Open.socket init}
P={S bind(port:$)}
{S listen}

declare
class Accepted from Open.socket
   meth report(H P)
      {Browse read(host:H port:P read:{self read(list:$)})}
      {self report(H P)}
   end
end

proc {Accept}
   H P A
in
   {S accept(acceptClass:Accepted
             host:?H port:?P accepted:?A)}
   thread 
      {A report(H P)} 
   end
   {Accept}
end

{Accept}

declare
C1={New Open.socket client(port:P)} 
C2={New Open.socket client(port:P)}

declare
{C1 write(vs:'hello from C1')}



%%
%% Datagram Sockets
%%

declare
S={New Open.socket init(type:datagram)}
T={New Open.socket init(type:datagram)}

declare
SPN={S bind(port:$)}
TPN={T bind(port:$)}

{S send(vs:'really '#"great" port:TPN)}

declare Is P
{T receive(list:?Is port:?P)}
{Browse Is#' from: '#P}



%%
%% Example: Are We Working Right Now?
%%

declare
FingerPort={OS.getServByName finger tcp}

declare
class FingerClient from Open.socket
   meth getInfo($)
      Is Ir 
   in
      if {self read(list:Is tail:Ir len:$)}==0 then nil
      else {self getInfo(Ir)} Is
      end
   end
end
FC = {New FingerClient client(host:'wallaby.ps.uni-sb.de' 
                              port:FingerPort)}

{FC write(vs:'schulte\n')}
{Browse {FC getInfo($)}}



%%%
%%% Chapter: Running Processes
%%%


declare
class Shell from Open.pipe Open.text
   meth init
      Open.pipe,init(cmd:"sh" args:["-s"]) 
   end
   meth cmd(Cmd) 
      Open.text,putS(Cmd) 
   end
   meth show
      case Open.text,getS($) of false then
         {Browse 'Shell has died.'} {self close}
      elseof S then {Browse S}
      end
   end
end

declare
S={New Shell init}

{S cmd(cd)}
{S cmd(ls)}

{S show}

{S close}




