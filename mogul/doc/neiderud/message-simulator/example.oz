declare
Path='x-ozlib://neiderud/message-simulator/'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the module, create a few windows and initialize a simulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[GSEModule ControlFrameM]={Module.link [Path#"GraphicalSimulationEngine.ozf"
					Path#"ControlFrame.ozf"]}
ControlToplevel = {New Tk.toplevel
		   tkInit(title:"Distributed Mozart Simulator"
			  delete:proc{$} {Application.exit 0} end)}
NodeLinkToplevel = {New Tk.toplevel tkInit(title:"Node Layout" withdraw:true)}
MessageLogToplevel = {New Tk.toplevel
		      tkInit(title:"Message Log")}
NodeLinkFrame MessageLogFrame

GSE={New GSEModule.graphicalSimulationEngine
     init(NodeLinkToplevel MessageLogToplevel
	  NodeLinkFrame MessageLogFrame)}

{Tk.batch [grid(NodeLinkFrame row:0 column:0 sticky:news)
	   grid(columnconfigure NodeLinkToplevel 0 weight:1)
	   grid(rowconfigure NodeLinkToplevel 0 weight:1)]}
{Tk.batch [grid(MessageLogFrame row:0 column:0 sticky:news)
	   grid(columnconfigure MessageLogToplevel 0 weight:1)
	   grid(rowconfigure MessageLogToplevel 0 weight:1)]}

ControlFrame = {New ControlFrameM.controlFrame
		init(GSE ControlToplevel
		     NodeLinkToplevel MessageLogToplevel
		     showNodeLink:true
		    )}
{Tk.batch [grid(ControlFrame row:0 column:0 sticky:news)
	   grid(columnconfigure ControlToplevel 0 weight:1)
	   grid(rowconfigure ControlToplevel 0 weight:1)]}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test the simulator by creating some nodes and links and send messages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun{GetListener Id Out}
   proc{$ M}
      case M of step(_ Msgs) then
	 {ForAll Msgs proc{$ Msg#From}
			 case Msg of connectionLost then
			    {Show connnectionLost(fr:From)}
			 else
			    {Show got(Msg.content fr:From)}
			    if Out\=unit then
			       {GSE send(Out Msg)}
			    end
			 end
		      end}
	       end
   end
end

fun{RandBetween X Y}
   ({OS.rand} mod (Y-X+1))+X
end

fun{Loose}
   if {RandBetween 1 50}==10 then
      {Show loose}
      true
   else
      false
   end
end

proc{LossyShifter GetInMsg SlotArray NofSlots ?OutMsg}
   % Last msg arrives
   OutMsg = SlotArray.NofSlots

   % Messages inside SlotArray step one step forward unless Loose proves true
   {For NofSlots 2 ~1
    proc{$ N}
       Msg=SlotArray.(N-1)
    in
       if Msg==nil orelse {Loose} then
	  SlotArray.N:=nil
       else
	  SlotArray.N:=Msg
       end
    end}

   % One incomming message is moved into SlotArray
   SlotArray.1:={GetInMsg}
end

Msg=GSEModule.message


declare LAB LBA
{GSE createNode(a {GetListener a LAB})}
{GSE createNode(b {GetListener b LBA})}


LAB={GSE createLink(a b $ nofslots:5)}
LBA={GSE createLink(b a $ shifter:LossyShifter)}

{GSE send(LAB {New Msg init(hi)})}
{GSE send(LBA {New Msg init(hiagain)})}
/*

for N in 1..30000 do
   {GSE step}
   {Delay 200}
end

{GSE createNode(c {GetListen
er c unit})}
{GSE createNode(d {GetListener d unit})}
{GSE createNode(e {GetListener e unit})}
{GSE createNode(f {GetListener f unit})}
{GSE createNode(g {GetListener g unit})}
{GSE createNode(h {GetListener h unit})}
{GSE createNode(i {GetListener i unit})}
{GSE createNode(j {GetListener j unit})}

{GSE send({GSE createLink(c d $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(d c $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(b c $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(c b $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(b f $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(f b $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(c f $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(f c $ nofslots:5)} {New Msg init(hi)})}
{GSE send({GSE createLink(d b $ nofslots:5)} {New Msg init(hi)})}

{GSE createNode(special
		proc{$ State} {ForAll State.2
			       proc{$ Msg}
				  {Show special_got(Msg.1.content)}
			       end}
		end
		spec(color:white coords:200#2000))}
{GSE send({GSE createLink(a special $ nofslots:5)} {New Msg init(hi_special)})}

{GSE removeNode(a)}
{GSE removeNode(b)}
{GSE removeLink(LAB crash)}
{GSE removeLink(LAB flush)}
{GSE removeLink(LBA flush)}

declare LAB={GSE createLink(a b $ nofslots:5)}

{ControlFrame showNodes}
{ControlFrame hideNodes}
*/
