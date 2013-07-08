functor
   import 
      Application 
      Open
   define
      Args = {Application.getArgs record('in'(single type:string)
                                         'out'(single type:string))}
      Status = try
                  I={New Open.file init(url:  Args.'in')}
                  O={New Open.file init(name: Args.'out' 
                                        flags:[write create truncate])}
               in
                  local
                     proc {Copy}
                        S={I read(list:$)}
                     in
                        if S\="" then 
                           {O write(vs:S)} {Copy} 
                        end
                     end
                  in 
                     {Copy}
                  end
                  0
               catch _ then 1
               end
      {Application.exit Status}
end