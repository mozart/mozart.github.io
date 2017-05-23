%%% Copyright (c) by Denys Duchier, Dec 1999, Universitaet des Saarlandes
functor
import
   Application System(showInfo:ShowInfo)
   X('class':Processor) at 'x-ozlib://duchier/xml/expat/Processor.ozf'
define
   class Indentor from Processor
      attr indent:'' incr
      meth init(N Urls)
	 incr <- {List.make N}
	 {ForAll @incr proc {$ C} C=&  end}
	 if Urls==nil then
	    Processor,initFromFile(stdin)
	 else
	    Processor,initFromURLs(Urls)
	 end
      end
      meth startElement(Tag _)
	 {ShowInfo @indent#Tag}
	 indent<- @incr # @indent
      end
      meth endElement(Tag)
	 case @indent of _#I then indent<-I end
      end
   end
   Args = {Application.getArgs
	   record('indent'(single char:&i type:int default:2))}
   Obj  = {New Indentor init(Args.indent Args.1)}
   {Obj parse}
   {Application.exit 0}
end
