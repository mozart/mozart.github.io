functor
import
   Tk
export
   Book
define
   proc {Book Fs ?Get}
      %% Takes a list of flights and returns the booked flight
      %% and information on the booking user
      T ={New Tk.toplevel tkInit}
      F1={New Tk.frame    tkInit(parent:T relief:sunken bd:2)}
      V ={New Tk.variable tkInit(Fs.1.key)}
      {Tk.batch 
       grid(b({Map ['' 'From' 'To' 'Price']
               fun {$ A}
                  {New Tk.label tkInit(parent:F1 text:A
                                       relief:raised bd:1)}
               end})
            padx:1 pady:1 sticky:ew) |
       {Map Fs
        fun {$ F}
           grid({New Tk.radiobutton tkInit(parent:F1 var:V
                                           value:F.key)}
                b({Map ['from' to price]
                   fun {$ A}
                      {New Tk.label tkInit(parent:F1 text:F.A)}
                   end}))
        end}}
      F2={New Tk.frame tkInit(parent:T)}
      [FN LN EM] =
      {Map ['First name' 'Last name' 'E-Mail']
       fun {$ S}
          E={New Tk.entry tkInit(parent:F2 width:20 bg:wheat)}
       in
          {Tk.send grid({New Tk.label
                         tkInit(parent:F2 text:S#':' anchor:w)}
                        E
                        sticky:ew)}
          fun {$}
             {E tkReturnAtom(get $)}
          end
       end}
      B={New Tk.button
         tkInit(parent:T text:'Okay'
                action: proc {$}
                           Get=form(first: {FN}
                                    last:  {LN}
                                    email: {EM}
                                    key:   {V tkReturnInt($)})
                           {T tkClose}
                        end)}
      in
      {Tk.send pack(F1 F2 B padx:1#m pady:2#m)}
   end
end
