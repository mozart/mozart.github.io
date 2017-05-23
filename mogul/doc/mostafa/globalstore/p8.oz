%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise transactions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc{Trans Out}
	 
   {Obj1 inc(1)}
   {Obj1 inc(~1)}
   {Obj2 inc(~1)}
   %%% Update is done in a new thread
   {LocalStore newthread(proc {$}  {Obj1 inc(1)} end)}
   %%%%       
   {Obj2 inc(2)}
   {Obj1 inc(1)}
   Out=state({Obj1 show($)})
end   
OutPut  % Output of Trans
Transid % Transaction Identifier
Res
in
   {LocalStore trans(Trans OutPut Res)} 
   %%%% check transaction
   %%%% The result is commit, abort 
   {Wait Res}
   {System.show Res}


