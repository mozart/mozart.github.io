%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example illustrating the GS
%% Author Almetwally Mostafa
%% Last Modification 27-8-2002
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
import 
   System(show:Show)
   Module
   Pickle
   Connection
   %Application
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
   NewObj LocalStore  Movehere LS
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
      {Show 'Object created '#X#Y}
      Tag={Canvas newTag($)}
      case {Access Colors $} of
	 Color|_ then Col=Color 
      [] nil then {Assign Colors ListColors} Col=red
      end
      {Assign Colors {List.drop {Access Colors $} 1 $}}  
      try	 
	 Sobj={NewObj  Rectangle init(X Y  Order Col)}
	 {Show 'Create: Object created'}
	 {Show 'Create: Object reference type: '#{Value.type Sobj}}
	 {Canvas create(rectangle X-50 Y-50 X+50 Y+50 fill:Col tags:Tag)}
	 {Sobj getuniqueobjectid(Order)}    %this is the global reference
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
			  TransRes 
			  proc {Trans Output}
			    {Sobj setcoord(X Y)}
			  end
			 
		       in
			  {Tag setCoords(X-50 Y-50 X+50 Y+50)}
			  % initialise transaction on Tag
			  {LocalStore trans(Trans _ TransRes)} 
			  {Wait TransRes}
		       end)}
         %delete this object from store
      {Tag bind(event:"<3>" 
		args:[int(x) int(y)]
		action:proc{$ X Y}
			  Res Order Go
			  
		       in
			  {Tag setCoords(X-50 Y-50 X+50 Y+50)}
			  {Sobj getuniqueobjectid(Order)}
			  try 
			     {LocalStore deleteobj(Sobj Res)}
			  catch E then {Show E}
			  end
			  {Wait Res}
			  if Res == commit then
			     {Dictionary.get Dictobjects Order Sobj#Go}
			     {Go delete}   
			     {Dictionary.remove Dictobjects Order}
			  else
			     {Show 'Draw: Object NOT deleted !!!'}
			  end
		       end)}
   end
   
   {Canvas bind(event:"<2>"
		args:[int(x) int(y) ]
		action:CreateRectangle)}
   
   UserId  
   
in
   %%%%%%%%%%%%%%%%%%%%%%%%%
   %% Initiate a local store
   %%%%%%%%%%%%%%%%%%%%%%%%%  
   try LS={Connection.take {Pickle.load './gsticket' $}}
   catch
    error(url(_ _) debug:_) then {Show 'url or file not found'}
   [] error(connection(_ _)  debug:_)  then {Show connectionfailed}
   end
   
   try
      {LS newLocal(Module user1  UserId ?NewObj ?LocalStore ?Movehere)}
   catch gs(connectionfailed)
   then
      {Show connectionfailed}
   end
   try {Pickle.save {Connection.offerUnlimited LocalStore $} './client1ticket'}
   catch
    error(url(_ _) debug:_) then {Show 'cannot create url or file '}
   [] error(connection(_ _)  debug:_)  then {Show 'connection Module error'}
   end
   %%% Save the MOvehere procedure
   try {Pickle.save {Connection.offerUnlimited Movehere $} './movehereticket'}
   catch
    error(url(_ _) debug:_) then {Show 'cannot create url or file '}
   [] error(connection(_ _)  debug:_)  then {Show 'connection Module error'}
   end 
   % set action when object creation
   {LocalStore setnotifycreation(
      proc {$ O}
	 Tag X Y Order in
	 {O getorder(Order)}
	 {Wait Order}
	 {O getcoord(X Y)}
	 {UpdateRectangle X Y O ?Tag}
	 {Dictionary.put  Dictobjects Order  O#Tag}
	 {Show 'NotifyCreate: Object created'}
	 {Show 'NotifyCreate: Object reference type: '#{Value.type O}}
      end)}
   
   % set action when receiving Obj object update
   {LocalStore setnotifyupdate(
    proc {$ ?Obj}
       Tag X Y Order Go   in
      
       {Obj getorder(Order)}
       {Wait Order}
       {Obj getcoord(X Y)}
       {Dictionary.get Dictobjects Order  Obj#Go}
       {Go delete}  % delete old tage
       {UpdateRectangle X Y Obj ?Tag} % create new tage
       {Dictionary.remove Dictobjects Order} % remove old tage from dictionary
       {Dictionary.put Dictobjects Order Obj#Tag}
     
    end)
   }
   
 
   {LocalStore setnotifydelete(
     proc {$ ?Obj}
	Go  Order  in
	{Obj getorder(Order)}
	{Dictionary.get Dictobjects Order  Obj#Go}
	{Dictionary.remove Dictobjects Order}
	{Go delete}
     end
    )
   }
   
   {Window show(wait:true)}
end





