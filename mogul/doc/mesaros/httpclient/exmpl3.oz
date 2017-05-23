%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simple use of the bytesRead, stopTemp and    %%
%% startTemp methods of HttpClient.urlGET class %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   System
   Application
   HTTPClient at 'x-ozlib://mesaros/net/HTTPClient.ozf' 
define
   Url = "http://rfc.fh-koeln.de/rfc/html/rfc0959.html"
   OutPrms
   proc {UseIt}
      HCObj
      ServiceEnd
      proc {GetRate Stream}
	 case Stream of nil then skip
	 [] X|Xr then
	    if X\=nil then
	       {System.show X#{HCObj bytesRead($)}}
	       {GetRate Xr}	       
	    end
	 end
      end      
   in      
      HCObj={New HTTPClient.urlGET init(inPrms(toFile:false tInterval:350) _)}
      thread
	 try
	    {HCObj getService(Url OutPrms _)}
	 catch E then
	    {System.show E}
	 finally 
	    ServiceEnd=unit
	 end
      end
      thread {GetRate OutPrms.rateStrm} end
      {Delay 850}
      {HCObj stopTemp}
      {Delay 3000}
      {HCObj startTemp}
      {Wait ServiceEnd}
   end
in
   {UseIt}
   {Application.exit 0}
end
