%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rate based document download  %%
%% using HttpClient.urlGET class %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor  
import
   System
   Application
   HTTPClient at 'x-ozlib://mesaros/net/HTTPClient.ozf' 
define
   fun {GetDoc Url}
      proc {GetRate Stream PrevTime PLock} LLock in
	 case Stream of nil then
	    PLock=unit
	    Continue=true
	 [] X|Xr then
	    if X\=nil then Tp in
	       PLock=unit
	       if X.1<RateTh then Dif in
		  if {IsDet PrevTime} then
		     Dif = {Cell.access TimeCounter}+(X.2-PrevTime)
		  else Dif = 0 end
		  {Cell.assign TimeCounter Dif}
		  Tp = TimePeriod
	       else
		  {Cell.assign TimeCounter 0}
		  Tp = 2*TimePeriod
	       end
	       {WaitFor Tp-{Cell.access TimeCounter} LLock}
	       {GetRate Xr X.2 LLock}
	    else
	       PLock=unit
	       if {IsFree Continue} then Continue=false end
	    end
	 end
      end
      proc {WaitFor Td WLock}
	 thread
	    {Delay Td}
	    if {IsFree WLock} then
	       Continue=true
	       {HCObj closeAll(false)}
	    end
	 end
      end
      HCObj
      OutPrms
      TimeCounter = {Cell.new 0}
      Continue	 
   in
      {System.show trying#{VirtualString.toAtom Url}}
      HCObj={New HTTPClient.urlGET init(_ _)}
      thread {GetRate OutPrms.rateStrm _ _} end
      try
	 {HCObj getService(Url OutPrms _)}
      catch _ then
	 Continue = true
      end
      Continue
   end
   Urls = ["http://www.ring.gr.jp/pub/doc/RFC/rfc2616.txt"
	   "http://sunsite.doc.ic.ac.uk/rfc/rfc2616.txt"]
   TimePeriod = 1000    %% milliseconds
   RateTh = 25.0        %% KB/s
in
   {List.dropWhile Urls GetDoc _}
   {Application.exit 0}
end



