%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simple use of HttpClient.cgiGET class %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   System
   Application
   HTTPClient at 'x-ozlib://mesaros/net/HTTPClient.ozf' 
define
   Url = "search.yahoo.com/bin/search"
   CgiParams = ["p"#"travel"]
   OutPrms
   HRepPrms
   HCObj
in   
   HCObj={New HTTPClient.cgiGET init(inPrms(file:"ysearch")
				     httpReqPrms(accept_language:"fr-BE, en"))}
   try
      {HCObj getService(Url CgiParams OutPrms HRepPrms)}
   catch E then
      {System.show E}
   end
   {System.show sizeread#OutPrms.sizeRead}
   {System.show http_server#{VirtualString.toAtom HRepPrms.server}}
   {Application.exit 0}
end
