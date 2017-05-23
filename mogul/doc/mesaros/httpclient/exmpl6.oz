%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Avoiding system blocking           %%
%%            by using Virtual Sites            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   Application
   System
   Remote
define
   Funct = functor
	   import
	      System(show:Show)
	      HTTPClient at 'x-ozlib://mesaros/net/HTTPClient.ozf'
	   define	      
	      proc {FetchRate}
		 if {IsFree ServiceEnd} then
		    {Delay 300}
		    {Show rate#{HCObj fetchRate($)}.1}
		    {FetchRate}
		 end
	      end 
	      proc {UseIt}     
		 HCObj={New HTTPClient.urlGET init(_ _)}
		 thread {FetchRate} end
		 try
		    {HCObj getService(Url _ _)}
		 catch E then
		    {Show E}
		 finally
		    ServiceEnd = unit
		 end
	      end
	      HCObj
	      ServiceEnd
	      Url="http://elle.c5.utcluj.ro"
	   in
	     {UseIt}
	   end
   proc {Loop N}
      if N>0 then
	 {Delay 100}
	 {System.show looping#N}
	 {Loop N-1}
      end
   end
   thread {Loop 3000} end   
   R={New Remote.manager init}
   {R apply(Funct _)}
   {Application.exit 0}
end
