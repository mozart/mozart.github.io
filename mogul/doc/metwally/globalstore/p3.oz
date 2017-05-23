%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create an object in the store
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obj1 Obj2 Obj3 are references in
%  the local  store 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
declare
class Counter
   attr val
   meth show(Value) Value=@val end
   meth inc(Value) val <- @val+Value end
   meth init(Value) val <- Value end  
end
Obj1 Obj2 Obj3
in
Obj1={NewObj  Counter init(0)}
Obj2={NewObj  Counter  init(0)}
Obj3={NewObj  Counter  init(0)}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Save  Obj1 reference to use it on other users
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{LocalStore saveobj(Obj1 'obj1')}
