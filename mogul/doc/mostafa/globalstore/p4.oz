%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Procedure to show a coherent
% snapshot of the global store
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc {CoherentSnapshot}       
   proc{Trans ?Output}
      Val1 Val2 Val3 in
      {Obj1 show(Val1)} 
      {Obj2 show(Val2)}
      {Obj3 show(Val3)}
      Output=state(Val1 Val2 Val3)
   end
   Transid
   Out
   Result
in     
   {LocalStore trans(Trans ?Out ?Result)}
   {Wait Result}
   if Result==commit  then
      {Show 'Obj1:'#Out.1#'Obj2:'#Out.2#'Obj3:'#Out.3}
   else
      skip
   end	 
   
end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Non cohernent query without transaction one can call  %%%%%%
%%%%% read only methed that will not change the object state %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{Show {Obj1 show($)}} 
{Show {Obj2 show($)}}
{Show {Obj3 show($)}}
