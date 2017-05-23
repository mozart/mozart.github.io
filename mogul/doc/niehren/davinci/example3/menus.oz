%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this functor generates menus at nodes and edges %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% the exported functions take an argument which contains
%% the required parameters for the actions, and they
%% return a menu entry : menu_entry(MenuProc MenuLabel)
%% MenuProc refers to the procedure that will be called
%% when the menu entry is chosen, it is constructed by
%% the menu-actions functor.
%% MenuLabel refers to the atom which is shown at the menu

functor
import
   Actions(
      remove
      hello
      quit
      ) at 'menu-actions.ozf'

export
   Remove
   Hello
   Quit

define
   fun{Remove Kind}
      MenuProc = {Actions.remove Kind}
      MenuLabel = {VirtualString.toAtom 'Remove - '#Kind}
   in
      menu_entry(MenuProc MenuLabel)
   end
   
   fun{Hello Para}
      MenuProc = {Actions.hello Para.kind}
      MenuLabel = 'Hello'
   in
      if {HasFeature Para icon} then
	 icon_entry(MenuProc Para.icon MenuLabel)
      else
	 menu_entry(MenuProc MenuLabel)
      end
   end

   fun{Quit Para}
      MenuProc = {Actions.quit}
      MenuLabel = 'Quit'
   in
      if {HasFeature Para icon} then
	 icon_entry(MenuProc Para.icon MenuLabel)
      else
	 menu_entry(MenuProc MenuLabel)
      end
      
   end
   
end
