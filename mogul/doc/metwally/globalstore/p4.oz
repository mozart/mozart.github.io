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
   {LocalStore trans(Trans ?Out ?Transid)}
   {LocalStore checktrans(Trid Result _)}		 
   if Result==commit  then
      {Show 'Obj1:'#Out.1#'Obj2:'#Out.2#'Obj3:'#Out.3}
   else
      skip
   end	 
   
end  
