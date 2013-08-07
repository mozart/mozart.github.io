functor
import
   DB Form            % User defined
   System Application % System
define
   %% Enter some flights
   {ForAll [f('from':'Paris'       to:'Stockholm'   price:234)
            f('from':'Saarbrücken' to:'Paris'       price:345)
            f('from':'New York'    to:'Saarbrücken' price:567)
            f('from':'New York'    to:'Bruxelles'   price:363)
            f('from':'Paris'       to:'Saarbrücken' price:834)
            f('from':'Stockholm'   to:'Bruxelles'   price:333)
            f('from':'London'      to:'Saarbrücken' price:523)
            f('from':'Saarbrücken' to:'London'      price:457)
            f('from':'Bruxelles'   to:'New York'    price:324)
            f('from':'Boston'      to:'Stockholm'   price:765)
            f('from':'Stockholm'   to:'New York'    price:344)
            f('from':'Sydney'      to:'Saarbrücken' price:3452)
            f('from':'Sydney'      to:'Stockholm'   price:2568)] DB.add}
   %% Book until all flights sold out
   proc {Book}
      case {DB.getAll}
      of nil then
         {System.showInfo 'All flights sold.'}
      [] Fs then
         O={Form.book Fs}
      in
         {System.showInfo ('Booked: '#O.key#
                           ' for: '#O.first#
                           ' '#O.last#
                           ' ('#O.email#')')}
         {DB.remove O.key}
         {Book}
      end
   end
   {Book}
   {Application.exit 0}
end
       