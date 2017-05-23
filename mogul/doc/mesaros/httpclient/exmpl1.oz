%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simple use of HttpClient.urlGET class %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   System
   Application
   HTTPClient at 'x-ozlib://mesaros/net/HTTPClient.ozf' 
define
   proc {GetDoc Url}
      HCObj
   in   
      HCObj={New HTTPClient.urlGET init(_ _)}
      try
	 {HCObj getService(Url _ _)}
      catch E then
	 {System.show E}
      end
   end
in
   {GetDoc "http://www.info.ucl.ac.be/index.html"}
   {Application.exit 0}
end
