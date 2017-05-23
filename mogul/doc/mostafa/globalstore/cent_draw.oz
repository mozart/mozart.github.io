functor
import
   QTk
export
define
  Canvas
  Desc=td(canvas( handle:Canvas
		  glue:nswe
		  bg:white))		 
   Window={QTk.build Desc}   
   ListColors= [red green blue yellow]
   Colors={NewCell ListColors}
   proc{CreateRectangle X Y}
     Tag
     Col
   in
      Tag={Canvas newTag($)}
      case {Access Colors $} of
	 Color|_ then Col=Color 
      [] nil then {Assign Colors ListColors} Col=red
      end   
      {Assign Colors {List.drop {Access Colors $} 1 $}}
      {Canvas create(rectangle X-50 Y-50 X+50 Y+50 fill:Col tags:Tag)}
      {Bindevent Tag}               
   end
   proc {Bindevent Tag}     
      {Tag bind(event:"<B1-ButtonRelease>"
		args:[int(x) int(y)]
		action:proc{$ X Y}
			  {Tag setCoords(X-50 Y-50 X+50 Y+50)}
		       end)}
   end
   {Canvas bind(event:"<2>"
		args:[int(x) int(y) ]
	       action:CreateRectangle)} 
in  
 {Window show(wait:true)}
end
