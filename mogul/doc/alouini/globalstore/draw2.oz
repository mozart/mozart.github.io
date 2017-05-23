%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example illustrating the GS
%% Author IA
%% Last Modification 20-3-2000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   System(show:Show)
   Module
   Application
   Connection
   Pickle
export
define
   %%% rectangle object class in the Global Store
   class Rectangle
      prop locking
      attr
	 ox:0
	 oy:0
	 order
	 color
      meth init(X Y Order Color)
	 ox <- X
	 oy <- Y
	 order <- Order
	 color <- Color
      end
      meth getcoord(X Y)
	 lock
	    X=@ox
	    Y=@oy
	 end
      end
      meth setcoord(X Y)
	 lock
	    ox <- X 
	    oy <- Y 
	 end
      end
      meth getorder(O)
	 O=@order
      end
      meth getcolor(Col)
	 Col=@color
      end
   end
   
   [QTk]={Module.link ["./QTk.ozf"]}  
   Canvas
   Desc=td(canvas(
		  handle:Canvas
		  glue:nswe
		  bg:white))
		  %tdscrollbar:true
		  %lrscrollbar:true))   
   Window={QTk.build Desc}   
   
   %%%%%%% Dictionary of pairs order store object, store object#graphic object
   Dictobjects={NewDictionary $}
   NewObj LocalStore LS Movehere
   ListColors= [red green blue yellow]
   Colors={NewCell ListColors}
   proc{UpdateRectangle X Y Obj ?Tag}       
      Tag={Canvas newTag($)} 
      {Canvas create(rectangle X-50 Y-50 X+50 Y+50 fill:{Obj getcolor($)} tags:Tag)}
      {Bindevent Tag Obj}     
   end
   proc{CreateRectangle X Y}
      Order Sobj      
      Tag
      Col
   in
      Tag={Canvas newTag($)}
      case {Access Colors $} of
	 Color|_ then Col=Color 
      [] nil then {Assign Colors ListColors} Col=red
      end   
      {Assign Colors {List.drop {Access Colors $} 1 $}}
      try
	 Sobj={NewObj  Rectangle init(X Y  Order Col)}
	 {Canvas create(rectangle X-50 Y-50 X+50 Y+50 fill:Col tags:Tag)}
	 {LocalStore getuniqueident(?Order)}     
	 {Dictionary.put Dictobjects Order Sobj#Tag}
	 {Bindevent Tag Sobj}
   catch gs(global_store_temporary_failed) then
      {Show 'Object not created: retry'}
   end              
   end  
   proc {Bindevent Tag  Sobj}     
      {Tag bind(event:"<B1-ButtonRelease>"
		args:[int(x) int(y)]
		action:proc{$ X Y}
			  Out Transid
			  proc {Trans Output}
			    {Sobj setcoord(X Y)}
			  end
		       in
			  {Tag setCoords(X-50 Y-50 X+50 Y+50)}
			  % initialise transaction on Tag
			  {LocalStore trans(Trans Out Transid)}
			  %{LocalStore checktrans(Transid Res _)}		  
		       end)}
   end
   {Canvas bind(event:"<2>"
		args:[int(x) int(y) ]
	       action:CreateRectangle)}
   
  RedrawAll
in
   %%%%%%%%%%%%%%%%%%%%%%%%%
   %% Initiate a local store
   %%%%%%%%%%%%%%%%%%%%%%%%%
    
   try LS={Connection.take {Pickle.load './client1ticket' $}}
   catch
    error(url(_ _) debug:_) then {Show 'url or file not found'}
   [] error(connection(_ _)  debug:_)  then {Show connectionfailed}
   end   
   
   try
      {LS newlocal(Module user1  ?NewObj?LocalStore ?Movehere)}
   catch gs(connectionfailed)
   then
      {Show connectionfailed}
   end
   
  
  % set action when object creation
   {LocalStore setactioncreation(
      proc {$ O}
	 Tag X Y Ord in
	 {O getorder(Ord)}
	 {Wait Ord}
	 {O getcoord(X Y)}
	 {UpdateRectangle X Y O ?Tag}
	 {Dictionary.put  Dictobjects Ord  O#Tag}
      end)}
   %%%% Redraw All Objects
   proc {RedrawAll}
       Entries En  in
       % sort Graphic objects
       {Dictionary.keys Dictobjects ?Entries}
      {List.sort Entries Value.'<' ?En}
     
       % redraw all objects in order
       {ForAll En
	proc {$ Order}
	   O  X Y Tag   Go in
	   {Dictionary.get Dictobjects Order  O#Go}
	   {Go delete}
	   {O getcoord(X Y)}
	   {Go delete}
	   {UpdateRectangle X Y O ?Tag}
	   {Dictionary.remove Dictobjects Order}
	   {Dictionary.put Dictobjects Order O#Tag}
	end
       }
    end
    % set action when receiving Obj object update
   {LocalStore setactionupdates(
    proc {$ ?Obj}
      {RedrawAll}
    end)
   }
   {LocalStore setactionabort(
     proc {$ ?Obj}
	{RedrawAll}
     end
    )
   }
   {Window show(wait:true)}
end
