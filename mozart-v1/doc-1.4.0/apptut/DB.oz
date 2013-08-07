functor
  export
     add:    Add
     get:    Get
     getAll: GetAll
     remove: Remove
  define
     Data = {Dictionary.new}
     Ctr  = {New class $
                    prop locking
                    attr i:0
                    meth init(I <= 0)
                       lock i := I end
                    end
                    meth get($)
                       lock @i end
                    end
                    meth inc($)
                       lock I=@i+1 in i := I I end
                    end
                 end init()}
     
     proc {Add X}
        I={Ctr inc($)}
     in
        {Dictionary.put Data I X}
     end
        
     fun {Get ID}
        {Dictionary.get Data ID}
     end

     fun {GetAll}
        {Map {Dictionary.keys Data}
         fun {$ K}
            {AdjoinAt {Dictionary.get Data K} key K}
         end}
     end
     
     proc {Remove ID}
        {Dictionary.remove Data ID}
     end
end