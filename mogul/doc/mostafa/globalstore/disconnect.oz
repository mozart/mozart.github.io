%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% disconnect from GlobalStore  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
{LocalStore disconnect(Res)}
{Wait Res}
if Res==true
then {Application.exit 0}
else
{Show 'disconnaction fails during recovery'}
end
%%%%%%%%%%%%%
