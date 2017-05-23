%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% delteing Obje2 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc{Delete}
Res in
{LocalStore deleteobj(Obj2 ?Res)}
{Wait Res}
{Show objectdeletionresult#Res}
end	
{Delete}
%%%%%%%%%%%%%%%%%%%%%%%%%
