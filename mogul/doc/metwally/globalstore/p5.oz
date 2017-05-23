%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise transactions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc{Trans Out}
   if {IsOdd {Obj1 show($)}} 
      {Obj1 inc(1)}
      {Obj1 inc(~1)}
      {Obj2 inc(~1)}       
      {Obj2 inc(2)}
   else
      skip
   end
   Out=state({Obj1 show($)})
end   
OutPut  % Output of Trans
Transid % Transaction Identifier
in
   {LocalStore trans(Trans ?OutPut ?Transid)} 
   %%%% check transaction
   %%%% The result is commit, abort 
   {System.show {LocalStore checktrans(Transid $)}}
