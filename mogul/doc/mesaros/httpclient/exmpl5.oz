%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parallel document retrieval   %%
%% using HttpClient.urlGET class %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   System
   Application
   HTTPClient at 'x-ozlib://mesaros/net/HTTPClient.ozf' 
define
   Url1 = "http://www.ring.gr.jp/pub/doc/RFC/rfc2616.txt"
   Url2 = "http://sunsite.doc.ic.ac.uk/rfc/rfc2616.txt"
   proc {UseIt}
      HCObj1 HCObj2
      OutPrms1 OutPrms2 
      ServiceEnd1 ServiceEnd2
   in      
      HCObj1={New HTTPClient.urlGET init(inPrms(overwr:false) _)}
      HCObj2={New HTTPClient.urlGET init(inPrms(overwr:false) _)}
      thread
	 try
	    {HCObj1 getService(Url1 OutPrms1 _)}
	    {System.show thread1#finished}
	    {HCObj2 closeAll(false)}
	    ServiceEnd1=unit
	 catch E then
	    {System.show E}
	    ServiceEnd1=unit
	 end
      end
      thread
	 try
	    {HCObj2 getService(Url2 OutPrms2 _)}
	    {System.show thread2#finished}
	    {HCObj1 closeAll(false)}
	    ServiceEnd2=ServiceEnd1   
	 catch E then
	    {System.show E}
	    ServiceEnd2=ServiceEnd1
	 end
      end
      {Wait ServiceEnd2}
   end
in
   {UseIt}
   {Application.exit 0}
end
