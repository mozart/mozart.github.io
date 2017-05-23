%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise transactions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc{Trans Out}
   % Synchronous waiting for locks on Obj1 Obj2
   % if lock obtained -> ok
   % else Trans aborted
   {LocalStore waitlocks([Obj1 Obj2])} 
   {Obj1 inc(1)}
   {Obj1 inc(~1)}
   {Obj2 inc(~1)}     
   {Obj2 inc(2)}
   {Obj1 inc(1)}
   Out=state({Obj1 show($)})
end   
OutPut  % Output of Trans
Transid % Transaction Identifier
Res
in
   {LocalStore trans(Trans OutPut ?Transid)} 
   %%%% check transaction
   %%%% The result is commit, abort 
   {LocalStore checktrans(Transid Res _)}
   {System.show Res}

