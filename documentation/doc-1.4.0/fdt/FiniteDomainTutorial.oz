%%%
%%% Chapter: Writing Problem Solvers in Oz
%%%

%%
%% Example: Send More Money
%%

declare
proc {Money Root}
   S E N D M O R Y
in
   Root = sol(s:S e:E n:N d:D m:M o:O r:R y:Y)       % 1
   Root ::: 0#9                                      % 2
   {FD.distinct Root}                                % 3
   S \=: 0                                           % 4
   M \=: 0
                1000*S + 100*E + 10*N + D            % 5
   +            1000*M + 100*O + 10*R + E
   =: 10000*M + 1000*O + 100*N + 10*E + Y
   {FD.distribute ff Root}
end

{Browse {SearchAll Money}}



%%
%% The Explorer
%%

{ExploreAll Money}

{ExploreOne Money}



%%
%% New Primitives
%%

declare
proc {Money Root}
   S E N D M O R Y
in
   Root = sol(s:S e:E n:N d:D m:M o:O r:R y:Y)
   {FD.dom 0#9 Root}
   {FD.distinct Root}
   {FD.sum [S] '\\=:' 0}
   {FD.sum [M] '\\=:' 0}
   {FD.sumC
    [1000  100   10  1  1000  100  10  1  ~10000  ~1000  ~100  ~10  ~1]
    [   S    E    N  D     M    O   R  E       M      O     N    E   Y]
    '=:'
    0}
   {FD.distribute ff Root}
end

{ExploreAll Money}



%%
%% Watching Propagators
%%

declare X Y Z 
{Browse [X Y Z]}         % [X Y Z]
X :: 1#13                % [X[1#13] Y Z]
Y :: 0#27                % [X[1#13] Y[0#27] Z]
Z :: 1#12                % [X[1#13] Y[0#27] Z[1#12]]
2*Y =: Z                 % [X[1#13] Y[1#6]  Z[2#12]]
X <: Y                   % [X[1#5]  Y[2#6]  Z[4#12]]
Z <: 7                   % [X[1#2]  Y[2#3]  Z[4#6]]
X \=: 1                  % [2 3 6]



%%
%% Example: Safe
%%

declare
proc {Safe C}
   {FD.tuple code 9 1#9 C}
   {FD.distinct C}
   C.4 - C.6 =: C.7
   C.1 * C.2 * C.3 =: C.8 + C.9
   C.2 + C.3 + C.6 <: C.8
   C.9 <: C.8
   {For 1 9 1 proc {$ I} C.I \=: I end}
   {FD.distribute ff C}
end

{ExploreAll Safe}



%%%
%%% Chapter: Elimination of Symmetries and Defined Constraints
%%%

%%
%% Example: Grocery
%%

declare
proc {Grocery Root}
   A#B#C#D = Root
   S       = 711
in
   Root ::: 0#S
   A+B+C+D =: S
   A*B*C*D =: S*100*100*100
   %% eliminate symmetries
   A =<: B
   B =<: C
   C =<: D
   {FD.distribute generic(value:splitMax) Root}
end

{ExploreAll Grocery}



%%
%% Example: Family
%%

declare
proc {Family Root}
   fun {IsFamily Name}
      Coeffs    = [1 1 1 ~1 ~1 ~1]
      BoysAges  = {AgeList}
      GirlsAges = {AgeList}
      Ages      = {Append BoysAges GirlsAges}
   in
      {FD.distinct Ages}
      {FD.sumC Coeffs Ages '=:' 0}
      {FD.sumCN Coeffs {Map Ages fun {$ A} [A A] end} '=:' 0}
      Name(boys:BoysAges girls:GirlsAges)
   end
   proc {AgeList L}
      {FD.list 3 0#9 L}
      {Nth L 1} >: {Nth L 2}
      {Nth L 2} >: {Nth L 3}
   end
   Maria = {IsFamily maria}
   Clara = {IsFamily clara}
   AgeOfMariasYoungestGirl = {Nth Maria.girls 3}
   AgeOfClarasYoungestGirl = {Nth Clara.girls 3}
   Ages = {FoldR [Clara.girls Clara.boys Maria.girls Maria.boys] 
           Append nil}
in
   Root = Maria#Clara
   {ForAll Maria.boys proc {$ A} A >: AgeOfMariasYoungestGirl end}
   AgeOfClarasYoungestGirl = 0
   {FD.sum Ages '=:' 60}
   {FD.distribute split Ages}
end

{ExploreAll Family}



%%
%% Example: Zebra Puzzle
%%

declare
proc {Zebra Nb}
   Groups     = [ [english spanish japanese italian norwegian]
                  [green red yellow blue white]
                  [painter diplomat violinist doctor sculptor]
                  [dog zebra fox snails horse]
                  [juice water tea coffee milk] ]
   Properties = {FoldR Groups Append nil}
   proc {Partition Group}
      {FD.distinct {Map Group fun {$ P} Nb.P end}}
   end
   proc {Adjacent X Y}
      {FD.distance X Y '=:' 1}
   end
in
   %% Nb maps all properties to house numbers
   {FD.record number Properties 1#5 Nb}
   {ForAll Groups Partition}
   Nb.english = Nb.red
   Nb.spanish = Nb.dog
   Nb.japanese = Nb.painter
   Nb.italian = Nb.tea
   Nb.norwegian = 1
   Nb.green = Nb.coffee
   Nb.green >: Nb.white
   Nb.sculptor = Nb.snails
   Nb.diplomat = Nb.yellow
   Nb.milk = 3
   {Adjacent Nb.norwegian Nb.blue}
   Nb.violinist = Nb.juice
   {Adjacent Nb.fox Nb.doctor}
   {Adjacent Nb.horse Nb.diplomat}
   Nb.zebra = Nb.white
   {FD.distribute ff Nb}
end

{ExploreAll Zebra}



%%%
%%% Chapter: Parameterized Scripts
%%%

%%
%% Example: Queens
%%

declare
fun {Queens N}
   proc {$ Row}
      L1N ={MakeTuple c N} 
      LM1N={MakeTuple c N}
   in
      {FD.tuple queens N 1#N Row}
      {For 1 N 1 proc {$ I}
                    L1N.I=I LM1N.I=~I
                 end}
      {FD.distinct Row}
      {FD.distinctOffset Row LM1N}
      {FD.distinctOffset Row L1N}
      {FD.distribute generic(value:mid) Row}
   end
end

{ExploreOne {Queens 8}}

{ExploreAll {Queens 6}}



%%
%% Example: Changing Money
%%

declare
fun {ChangeMoney BillsAndCoins Amount}
   Available    = {Record.map BillsAndCoins fun {$ A#_} A end}
   Denomination = {Record.map BillsAndCoins fun {$ _#D} D end}
   NbDenoms     = {Width Denomination}
in
   proc {$ Change}
      {FD.tuple change NbDenoms 0#Amount Change}
      {For 1 NbDenoms 1 proc {$ I} Change.I =<: Available.I end}
      {FD.sumC Denomination Change '=:' Amount}
      {FD.distribute generic(order:naive value:max) Change}
   end
end

BillsAndCoins = bac(6#100  8#25  10#10  1#5  5#1)

{ExploreOne {ChangeMoney BillsAndCoins 142}}


{Browse {SearchOne {ChangeMoney BillsAndCoins 142}}}

{Browse {Length {SearchAll {ChangeMoney BillsAndCoins 142}}}}



%%%
%%% Chapter: Minimizing a Cost Function
%%%

%%
%% Example: Coloring a Map
%%

declare
fun {MapColoring Data}
   Countries = {Map Data fun {$ C#_} C end}
in
   proc {$ Color}
      NbColors  = {FD.decl}
   in
      {FD.distribute naive [NbColors]}
      %% Color: Countries --> 1#NbColors
      {FD.record color Countries 1#NbColors Color}
      {ForAll Data
       proc {$ A#Bs}
          {ForAll Bs proc {$ B} Color.A \=: Color.B end}
       end}
      {FD.distribute ff Color}
   end
end

Data = [ austria     # [italy switzerland germany]
         belgium     # [france netherlands germany luxemburg]
         france      # [spain luxemburg italy]
         germany     # [austria france luxemburg netherlands]
         italy       # nil
         luxemburg   # nil
         netherlands # nil
         portugal    # nil
         spain       # [portugal]
         switzerland # [italy france germany austria] ]

{ExploreOne {MapColoring Data}}



%%
%% Example: Conference
%%

declare
fun {Conference Data}
   NbSessions    = Data.nbSessions
   NbParSessions = Data.nbParSessions
   Constraints   = Data.constraints
   MinNbSlots    = NbSessions div NbParSessions
in
   proc {$ Plan}
      NbSlots  = {FD.int MinNbSlots#NbSessions}
   in
      {FD.distribute naive [NbSlots]}
      %% Plan: Session --> Slot
      {FD.tuple plan NbSessions 1#NbSlots Plan}
      %% at most NbParSessions per slot
      {For 1 NbSlots 1  
       proc {$ Slot} {FD.atMost NbParSessions Plan Slot} end}
      %% impose constraints
      {ForAll Constraints
       proc {$ C}
          case C
          of before(X Y) then 
             Plan.X <: Plan.Y
          [] disjoint(X Ys) then
             {ForAll Ys proc {$ Y} Plan.X \=: Plan.Y end}
          end
       end}
      {FD.distribute ff Plan}
   end
end

Data = data(nbSessions:11  nbParSessions:3
            constraints: [ before(4 11)  before(5 10)  before(6 11)
                           disjoint(1 [2 3 5 7 8 10])
                           disjoint(2 [3 4 7 8 9 11])
                           disjoint(3 [5 6 8])  disjoint(4 [6 8 10])
                           disjoint(6 [7 10])   disjoint(7 [8 9])
                           disjoint(8 [10]) ] )

{ExploreOne {Conference Data}}



%%%
%%% Chapter: Propagators for Redundant Constraints
%%%

%%
%% Example: Fractions
%%

declare
proc {Fractions Root}
   sol(a:A b:B c:C d:D e:E f:F g:G h:H i:I) = Root
   BC = {FD.decl}
   EF = {FD.decl}
   HI = {FD.decl}
in
   Root ::: 1#9
   {FD.distinct Root}
   BC =: 10*B + C
   EF =: 10*E + F
   HI =: 10*H + I 
   A*EF*HI + D*BC*HI + G*BC*EF =: BC*EF*HI
   %% impose canonical order
   A*EF >=: D*BC    
   D*HI >=: G*EF
   %% redundant constraints
   3*A >=: BC
   3*G =<: HI
   {FD.distribute ff Root}
end

{ExploreAll Fractions}



%%
%% Example: Pythagoras
%%

declare
local
   proc {Square X S}
      {FD.times X X S}
   end
in
   proc {Pythagoras Root}
      [A B C] = Root
      AA BB CC
   in
      Root ::: 1#1000
      AA = {Square A}
      BB = {Square B}
      CC = {Square C}
      AA + BB =: CC
      A =<: B
      B =<: C
      2*BB >=: CC  % redundant constraint
      {FD.distribute ff Root}
   end
end

{ExploreOne Pythagoras}

{Browse {Length {SearchAll Pythagoras}}}



%%
%% Example: Magic Squares
%%

declare
fun {MagicSquare N}
   NN  = N*N
   L1N = {List.number 1 N 1}  % [1 2 3 ... N]
in
   proc {$ Square}
      fun {Field I J}
         Square.((I-1)*N + J)
      end
      proc {Assert F}
         % {F 1} + {F 2} + ... + {F N} =: Sum
         {FD.sum {Map L1N F} '=:' Sum}
      end
      Sum = {FD.decl}
   in
      {FD.tuple square NN 1#NN Square}
      {FD.distinct Square}
      %% Diagonals
      {Assert fun {$ I} {Field I I} end}
      {Assert fun {$ I} {Field I N+1-I} end}
      %% Columns
      {For 1 N 1
       proc {$ I} {Assert fun {$ J} {Field I J} end} end}
      %% Rows
      {For 1 N 1
       proc {$ J} {Assert fun {$ I} {Field I J} end} end}
      %% Eliminate symmetries
      {Field 1 1} <: {Field N N}
      {Field N 1} <: {Field 1 N}
      {Field 1 1} <: {Field N 1}
      %% Redundant: sum of all fields = (number rows) * Sum
      NN*(NN+1) div 2 =: N*Sum
      %%
      {FD.distribute split Square}
   end
end

{ExploreOne {MagicSquare 4}}



%%%
%%% Chapter: Reified Constraints
%%%

%%
%% Example: Aligning for a Photo
%%

declare
proc {Photo Root}
   Persons       = [betty chris donald fred gary mary paul]
   Preferences   = [betty#gary betty#mary  chris#betty chris#gary
                    fred#mary  fred#donald paul#fred   paul#donald]
   NbPersons     = {Length Persons}
   Alignment     = {FD.record alignment Persons 1#NbPersons}
   Satisfaction  = {FD.decl} 
   proc {Satisfied P#Q S}
      {FD.reified.distance Alignment.P Alignment.Q '=:' 1 S}
   end
in
   Root = r(satisfaction: Satisfaction
            alignment:    Alignment)
   {FD.distinct Alignment}
   {FD.sum {Map Preferences Satisfied} '=:' Satisfaction}
   Alignment.fred <: Alignment.betty     % breaking symmetries
   {FD.distribute generic(order:naive value:max) [Satisfaction]}
   {FD.distribute split Alignment}
end

{ExploreOne Photo}



%%
%% Example:  Self-referential Aptitude Test
%%

declare
proc {SRAT Q}
   proc {Vector V}  % V is a 0/1-vector of length 10
      {FD.tuple v 10 0#1 V} 
   end
   proc {Sum V S}   % S is the sum of the components of vector V
      {FD.decl S} {FD.sum V '=:' S} 
   end
   proc {Assert I U V W X Y}  
      A.I=U  B.I=V  C.I=W  D.I=X  E.I=Y 
   end
   A      = {Vector}              B    = {Vector}
   C      = {Vector}              D    = {Vector}        E    = {Vector}
   SumA   = {Sum A}               SumB = {Sum B}         SumC = {Sum C}  
   SumD   = {Sum D}               SumE = {Sum E}
   SumAE  = {Sum [SumA SumE]}     SumBCD = {Sum [SumB SumC SumD]}
in
   {FD.tuple q 10 1#5 Q}
   {For 1 10 1
    proc {$ I} {Assert I  Q.I=:1  Q.I=:2  Q.I=:3  Q.I=:4  Q.I=:5} end}
   %% 1
   {Assert 1 B.2
             {FD.conj B.3 (B.2=:0)}
             {FD.conj B.4 (B.2+B.3=:0)}
             {FD.conj B.5 (B.2+B.3+B.4=:0)}
             {FD.conj B.6 (B.2+B.3+B.4+B.5=:0)}}
   %% 2
   {Assert 2  Q.2=:Q.3  Q.3=:Q.4  Q.4=:Q.5  Q.5=:Q.6  Q.6=:Q.7}
   Q.1\=:Q.2  Q.7\=:Q.8  Q.8\=:Q.9  Q.9\=:Q.10
   %% 3
   {Assert 3  Q.1=:Q.3  Q.2=:Q.3  Q.4=:Q.3  Q.7=:Q.3  Q.6=:Q.3}
   %% 4
   {FD.element Q.4 [0 1 2 3 4] SumA}
   %% 5
   {Assert 5  Q.10=:Q.5  Q.9=:Q.5  Q.8=:Q.5  Q.7=:Q.5  Q.6=:Q.5}
   %% 6
   {Assert 6  SumA=:SumB  SumA=:SumC  SumA=:SumD  SumA=:SumE  _}
   %% 7
   {FD.element Q.7 [4 3 2 1 0] {FD.decl}={FD.distance Q.7 Q.8 '=:'}}
   %% 8
   {FD.element Q.8 [2 3 4 5 6] SumAE}
   %% 9
   {Assert 9 SumBCD::[2 3 5 7]  SumBCD::[1 2 6]     
             SumBCD::[0 1 4 9]  SumBCD::[0 1 8]
             SumBCD::[0 5 10]}
   %% 10
   {FD.distribute ff Q}
end

{ExploreOne SRAT}



%%
%% Example: Bin Packing
%%

declare
fun {BinPacking Order}
   ComponentTypes = [glass plastic steel wood copper]
   MaxBinCapacity = 4
   proc {IsBin Bin}
      [Blue Red Green] = [0 1 2]
      BinTypes         = [Blue Red Green]
      Capacity         = {FD.int [1 3 4]}     % capacity of Bin
      Type             = {FD.int BinTypes}    % type of Bin
      Components 
      [Glass Plastic Steel Wood Copper] = Components
   in
      Bin = b(type:Type    glass:Glass  plastic:Plastic
              steel:Steel  wood:Wood    copper:Copper)
      Components ::: 0#MaxBinCapacity
      {FD.sum Components '=<:' Capacity}
      {FD.impl Wood>:0  Plastic>:0 1}   % wood requires plastic
      {FD.impl Glass>:0  Copper=:0 1}   % glass excludes copper
      {FD.impl Copper>:0  Plastic=:0 1} % copper excludes plastic
      thread
         case Type
         of !Red then Capacity=3  Plastic=0  Steel=0  Wood=<:1
         [] !Blue then Capacity=1  Plastic=0  Wood=0
         [] !Green then Capacity=4  Glass = 0  Steel=0  Wood=<:2
         end
      end
   end
   proc {IsPackList Xs}
      thread
         {ForAll Xs IsBin}
         {ForAllTail Xs  % impose order 
          proc {$ Ys}
             case Ys of A|B|_ then
                A.type =<: B.type
                {FD.impl A.type=:B.type  A.glass>=:B.glass  1}
             else skip 
             end
          end}
      end
   end
   proc {Match PackList Order}
      thread
         {ForAll ComponentTypes
          proc {$ C}
             {FD.sum {Map PackList fun {$ B} B.C end} '=:' Order.C}
          end}
      end
   end
   proc {Distribute PackList}
         NbComps = {Record.foldR Order Number.'+' 0}
         Div     = NbComps div MaxBinCapacity
         Mod     = NbComps mod MaxBinCapacity
         Min     = if Mod==0 then Div else Div+1 end
         NbBins  = {FD.int Min#NbComps}
         Types
         Capacities
      in
         {FD.distribute naive [NbBins]}
         PackList   = {MakeList NbBins} % blocks until NbBins is determined
         Types      = {Map PackList fun {$ B} B.type end}
         Capacities = {FoldR PackList
                       fun {$ Bin Cs}
                          {FoldR ComponentTypes fun {$ T Ds} Bin.T|Ds end Cs}
                       end
                       nil}
         {FD.distribute naive Types}
         {FD.distribute ff Capacities}
     end
in
   proc {$ PackList}
      {IsPackList PackList}
      {Match PackList Order}  
      {Distribute PackList}
   end
end

{Browse 
 {SearchOne 
  {BinPacking 
   order(glass:2 plastic:4 steel:3 wood:6 copper:4)}}}



%%%
%%% Chapter: User-Defined Distributors
%%%

%%
%% A Naive Distribution Strategy
%%

declare
proc {NaiveDistributor Is}
   {Space.waitStable}
   local
      Fs={Filter Is fun {$ I} {FD.reflect.size I}>1 end}
   in
      case Fs
      of nil then skip
      [] F|Fr then M={FD.reflect.min F} in
         choice F=M   {NaiveDistributor Fr}
         []     F\=:M {NaiveDistributor Fs}
         end
      end
   end
end



%%
%% A Domain-Splitting Distributor
%%

declare
proc {SplitDistributor Is}
   {Space.waitStable}
   local
      Fs={Filter Is fun {$ I} {FD.reflect.size I}>1 end}
   in 
      case Fs 
      of nil then skip
      [] F|Fr then 
         MinVar#_ = {FoldL Fr fun {$ Var#Size X}
                                 if {FD.reflect.size X}<Size then
                                    X#{FD.reflect.size X}
                                 else 
                                    Var#Size
                                 end
                              end F#{FD.reflect.size F}}
         Mid = {FD.reflect.mid MinVar} 
      in
         choice MinVar =<: Mid {SplitDistributor Fs}
         []     MinVar >: Mid  {SplitDistributor Fs}
         end
      end
   end
end



%%%
%%% Chapter: Branch and Bound
%%%

%%
%% Example: Aligning for a Photo, Revisited
%%

declare
proc {RevisedPhoto Root}
   Persons       = [betty chris donald fred gary mary paul]
   Preferences   = [betty#gary betty#mary  chris#betty chris#gary
                    fred#mary  fred#donald paul#fred   paul#donald]
   NbPersons     = {Length Persons}
   Alignment     = {FD.record alignment Persons 1#NbPersons}
   Satisfaction  = {FD.decl} 
   proc {Satisfied P#Q S}
      {FD.reified.distance Alignment.P Alignment.Q '=:' 1 S}
   end
in
   Root = r(satisfaction: Satisfaction
            alignment:    Alignment)
   {FD. distinct Alignment}
   {FD.sum {Map Preferences Satisfied} '=:' Satisfaction}
   Alignment.fred <: Alignment.betty     % breaking symmetries
   {FD.distribute split Alignment}
end

declare
proc {PhotoOrder Old New}
   Old.satisfaction <: New.satisfaction
end        

{ExploreBest RevisedPhoto PhotoOrder}



%%
%% Example: Locating Warehouses
%%

declare
Capacity   = supplier(3 1 4 1 4)
CostMatrix = store(supplier(36 42 22 44 52) 
                   supplier(49 47 134 135 121) 
                   supplier(121 158 117 156 115) 
                   supplier(8 91 120 113 101) 
                   supplier(77 156 98 135 11) 
                   supplier(71 39 50 110 98) 
                   supplier(6 12 120 98 93) 
                   supplier(20 120 25 72 156) 
                   supplier(151 60 104 139 77) 
                   supplier(79 107 91 117 154))
BuildingCost = 50
fun {Regret X}
   M = {FD.reflect.min X} 
in 
   {FD.reflect.nextLarger X M} - M
end
proc {WareHouse X}
   NbSuppliers = {Width Capacity}
   NbStores    = {Width CostMatrix}
   Stores      = {List.number 1 NbStores 1}
   Supplier    = {FD.tuple store NbStores 1#NbSuppliers}
   Open        = {FD.tuple supplier NbSuppliers 0#1}
   Cost        = {FD.tuple store NbStores 0#FD.sup}
   SumCost     = {FD.decl} = {FD.sum Cost '=:'}
   NbOpen      = {FD.decl} = {FD.sum Open '=:'}
   TotalCost   = {FD.decl}
in
   X = plan(supplier:Supplier cost:Cost totalCost:TotalCost)
   TotalCost =: SumCost + NbOpen*BuildingCost
   {For 1 NbStores 1
    proc {$ St}
       Cost.St :: {Record.toList CostMatrix.St}
       {FD.element Supplier.St CostMatrix.St Cost.St}
    end}
   {For 1 NbSuppliers 1
    proc {$ S} 
       {FD.atMost Capacity.S Supplier S}
       Open.S = {FD.reified.sum {Map Stores fun {$ St} 
                                               Supplier.St =: S 
                                            end} '>:' 0}
    end}
   {FD.distribute
    generic(order: fun {$ X Y} {Regret X} > {Regret Y} end)
    Cost}
end

{ExploreOne WareHouse}

declare
proc {Order Old New} 
   Old.totalCost >: New.totalCost 
end

{ExploreBest WareHouse Order}




%%%
%%% Chapter: Scheduling
%%%

%%
%% Building a House
%%

%% Problem Specification
declare
House = house(tasks: [a(dur:7            res:constructionInc) 
                      b(dur:3  pre:[a]   res:houseInc) 
                      c(dur:1  pre:[b]   res:houseInc) 
                      d(dur:8  pre:[a]   res:constructionInc) 
                      e(dur:2  pre:[c d] res:constructionInc) 
                      f(dur:1  pre:[c d] res:houseInc) 
                      g(dur:1  pre:[c d] res:houseInc) 
                      h(dur:3  pre:[a]   res:constructionInc) 
                      i(dur:2  pre:[f h] res:builderCorp) 
                      j(dur:1  pre:[i]   res:builderCorp) 
                      pe(dur:0 pre:[j])])


%% Building a House: Precedence Constraints
declare
local
   fun {GetDur TaskSpec}
      {List.toRecord dur {Map TaskSpec fun {$ T}
                                          {Label T}#T.dur
                                       end}}
   end
   fun {GetStart TaskSpec}
      MaxTime = {FoldL TaskSpec fun {$ Time T} 
                                   Time+T.dur
                                end 0}
      Tasks   = {Map TaskSpec Label}
   in
      {FD.record start Tasks 0#MaxTime}
   end
in
   fun {Compile Spec}
      TaskSpec = Spec.tasks
      Dur      = {GetDur TaskSpec}
   in
      proc {$ Start}
         Start = {GetStart TaskSpec}
         {ForAll TaskSpec
          proc {$ T}
             {ForAll {CondSelect T pre nil}
              proc {$ P}
                 Start.P + Dur.P =<: Start.{Label T}
              end}
          end}
         {FD.assign min Start}
      end
   end 
end

{ExploreOne {Compile House}}


%% Building a House: Capacity Constraints
declare
local
   fun {GetDur TaskSpec}
      {List.toRecord dur {Map TaskSpec fun {$ T}
                                          {Label T}#T.dur
                                       end}}
   end
   fun {GetStart TaskSpec}
      MaxTime = {FoldL TaskSpec fun {$ Time T} 
                                   Time+T.dur
                                end 0}
      Tasks   = {Map TaskSpec Label}
   in
      {FD.record start Tasks 0#MaxTime}
   end
   fun {GetTasksOnResource TaskSpec}
      D={Dictionary.new}
   in
      {ForAll TaskSpec 
       proc {$ T}
          if {HasFeature T res} then R=T.res in
             {Dictionary.put D R {Label T}|{Dictionary.condGet D R nil}}
          end
       end}
      {Dictionary.toRecord tor D}
   end
in
   fun {Compile Spec}
      TaskSpec   = Spec.tasks
      Dur        = {GetDur TaskSpec}
      TasksOnRes = {GetTasksOnResource TaskSpec}
   in
      proc {$ Start}
         Start = {GetStart TaskSpec}
         {Schedule.serializedDisj TasksOnRes Start Dur}
         {ForAll TaskSpec
          proc {$ T}
             {ForAll {CondSelect T pre nil}
              proc {$ P}
                 Start.P + Dur.P =<: Start.{Label T}
              end}
          end}
         {FD.distribute ff Start}
      end
   end 
end

declare
proc {Earlier Old New}
   Old.pe >: New.pe
end

{ExploreBest {Compile House} Earlier}


%% Ordering Tasks by Distribution
declare
local
   fun {GetDur TaskSpec}
      {List.toRecord dur {Map TaskSpec fun {$ T}
                                          {Label T}#T.dur
                                       end}}
   end
   fun {GetStart TaskSpec}
      MaxTime = {FoldL TaskSpec fun {$ Time T} 
                                   Time+T.dur
                                end 0}
      Tasks   = {Map TaskSpec Label}
   in
      {FD.record start Tasks 0#MaxTime}
   end
   fun {GetTasksOnResource TaskSpec}
      D={Dictionary.new}
   in
      {ForAll TaskSpec 
       proc {$ T}
          if {HasFeature T res} then R=T.res in
             {Dictionary.put D R {Label T}|{Dictionary.condGet D R nil}}
          end
       end}
      {Dictionary.toRecord tor D}
   end
in
   fun {Compile Spec}
      TaskSpec   = Spec.tasks
      Dur        = {GetDur TaskSpec}
      TasksOnRes = {GetTasksOnResource TaskSpec}
   in
      proc {$ Start}
         Start = {GetStart TaskSpec}
         {ForAll TaskSpec
          proc {$ T}
             {ForAll {CondSelect T pre nil}
              proc {$ P}
                 Start.P + Dur.P =<: Start.{Label T}
              end}
          end}
         {Schedule.serializedDisj TasksOnRes Start Dur}
         {Record.forAll TasksOnRes 
          proc {$ Ts}
             {ForAllTail Ts
              proc {$ T1|Tr}
                 {ForAll Tr
                  proc {$ T2}
                     choice Start.T1 + Dur.T1 =<: Start.T2
                     []     Start.T2 + Dur.T2 =<: Start.T1
                     end
                  end}
              end}
         end}
         {FD.assign min Start}
      end
   end 
end

declare
proc {Earlier Old New}
   Old.pe >: New.pe
end

{ExploreBest {Compile House} Earlier}



%%
%% Constructing a Bridge
%%

%% Problem specification
declare
Bridge =
bridge(tasks:
          [pa(dur: 0)
           a1(dur: 4 pre:[pa] res:excavator)
           a2(dur: 2 pre:[pa] res:excavator)
           a3(dur: 2 pre:[pa] res:excavator)
           a4(dur: 2 pre:[pa] res:excavator)
           a5(dur: 2 pre:[pa] res:excavator)
           a6(dur: 5 pre:[pa] res:excavator)
           p1(dur:20 pre:[a3] res:pileDriver)
           p2(dur:13 pre:[a4] res:pileDriver)
           ue(dur:10 pre:[pa])
           s1(dur: 8 pre:[a1] res:carpentry)
           s2(dur: 4 pre:[a2] res:carpentry)
           s3(dur: 4 pre:[p1] res:carpentry)
           s4(dur: 4 pre:[p2] res:carpentry)
           s5(dur: 4 pre:[a5] res:carpentry)
           s6(dur:10 pre:[a6] res:carpentry)
           b1(dur: 1 pre:[s1] res:concreteMixer)
           b2(dur: 1 pre:[s2] res:concreteMixer)
           b3(dur: 1 pre:[s3] res:concreteMixer)
           b4(dur: 1 pre:[s4] res:concreteMixer)
           b5(dur: 1 pre:[s5] res:concreteMixer)
           b6(dur: 1 pre:[s6] res:concreteMixer)
           ab1(dur:1 pre:[b1])
           ab2(dur:1 pre:[b2])
           ab3(dur:1 pre:[b3])
           ab4(dur:1 pre:[b4])
           ab5(dur:1 pre:[b5])
           ab6(dur:1 pre:[b6])
           m1(dur:16 pre:[ab1] res:bricklaying)
           m2(dur: 8 pre:[ab2] res:bricklaying)
           m3(dur: 8 pre:[ab3] res:bricklaying)
           m4(dur: 8 pre:[ab4] res:bricklaying)
           m5(dur: 8 pre:[ab5] res:bricklaying)
           m6(dur:20 pre:[ab6] res:bricklaying)
           l(dur:  2 res:crane)
           t1(dur:12 pre:[m1 m2 l] res:crane)
           t2(dur:12 pre:[m2 m3 l] res:crane)
           t3(dur:12 pre:[m3 m4 l] res:crane)
           t4(dur:12 pre:[m4 m5 l] res:crane)
           t5(dur:12 pre:[m5 m6 l] res:crane)
           ua(dur:10)
           v1(dur:15 pre:[t1] res:caterpillar)
           v2(dur:10 pre:[t5] res:caterpillar)
           pe(dur: 0 pre:[t2 t3 t4 v1 v2 ua])]
       constraints:
          proc {$ Start Dur}
             {ForAll [s1#b1 s2#b2 s3#b3 s4#b4 s5#b5 s6#b6]
              proc {$ A#B}
                 (Start.B + Dur.B) - (Start.A + Dur.A) =<: 4 
              end}
             {ForAll [a1#s1 a2#s2 a5#s5 a6#s6 p1#s3 p2#s4]
              proc {$ A#B}
                 Start.B - (Start.A + Dur.A) =<: 3
              end}
             {ForAll [s1 s2 s3 s4 s5 s6]
              proc {$ A}
                 Start. A >=: Start.ue + 6
              end}
             {ForAll [m1 m2 m3 m4 m5 m6]
              proc {$ A}
                 (Start.A + Dur.A) - 2 =<: Start.ua
              end}
             Start.l  =: Start.pa + 30
             Start.pa = 0
          end)


%% The scheduling compiler
declare
local
   fun {GetDur TaskSpec}
      {List.toRecord dur {Map TaskSpec fun {$ T}
                                          {Label T}#T.dur
                                       end}}
   end
   fun {GetStart TaskSpec}
      MaxTime = {FoldL TaskSpec fun {$ Time T} 
                                   Time+T.dur
                                end 0}
      Tasks   = {Map TaskSpec Label}
   in
      {FD.record start Tasks 0#MaxTime}
   end
   fun {GetTasksOnResource TaskSpec}
      D={Dictionary.new}
   in
      {ForAll TaskSpec 
       proc {$ T}
          if {HasFeature T res} then R=T.res in
             {Dictionary.put D R {Label T}|{Dictionary.condGet D R nil}}
          end
       end}
      {Dictionary.toRecord tor D}
   end
in
   fun {Compile Spec Capacity Serializer}
      TaskSpec    = Spec.tasks
      Constraints = if {HasFeature Spec constraints} then
                       Spec.constraints
                    else
                       proc {$ _ _} 
                          skip
                       end
                    end
      Dur         = {GetDur TaskSpec}
      TasksOnRes  = {GetTasksOnResource TaskSpec}
   in
      proc {$ Start}
         Start = {GetStart TaskSpec}
         {ForAll TaskSpec
          proc {$ T}
             {ForAll {CondSelect T pre nil}
              proc {$ P}
                 Start.P + Dur.P =<: Start.{Label T}
              end}
          end}
         {Constraints Start Dur}
         {Capacity   TasksOnRes Start Dur}
         {Serializer TasksOnRes Start Dur}
         {FD.assign min Start}
      end
   end 
end

%% Serializer that orders tasks by bottleneck criterion
declare
proc {DistributeSorted TasksOnRes Start Dur}
   fun {DurOnRes Ts}
      {FoldL Ts fun {$ D T} 
                   D+Dur.T 
                end 0}
   end
in  
   {ForAll {Sort {Record.toList TasksOnRes}
            fun {$ Ts1 Ts2}
               {DurOnRes Ts1} > {DurOnRes Ts2}
            end}
    proc {$ Ts}
       {ForAllTail Ts
        proc {$ T1|Tr}
           {ForAll Tr
            proc {$ T2}
               choice Start.T1 + Dur.T1 =<: Start.T2
               []     Start.T2 + Dur.T2 =<: Start.T1
               end
            end}
        end}
    end}
end

%% Solve the Bridge Problem
{ExploreBest {Compile Bridge
                      Schedule.serializedDisj
                      DistributeSorted} 
             Earlier}


%%
%% Strong Propagators for Capacity Constraints
%%

{ExploreBest {Compile Bridge 
                      Schedule.serialized
                      DistributeSorted} 
             Earlier}

declare
OptBridge = {AdjoinAt Bridge constraints
             proc {$ Start Dur}
                {Bridge.constraints Start Dur}
                Start.pe <: 104
             end}

{ExploreBest {Compile OptBridge 
                      Schedule.serializedDisj
                      DistributeSorted} 
             Earlier}

{ExploreBest {Compile OptBridge 
                      Schedule.serialized
                      DistributeSorted} 
             Earlier}

{ExploreBest {Compile OptBridge 
                      Schedule.taskIntervals
                      DistributeSorted} 
             Earlier}


%%
%% Strong Serializers
%%

{ExploreBest {Compile Bridge 
                      Schedule.serialized
                      Schedule.firstsDist} 
             Earlier}

{ExploreBest {Compile OptBridge 
                      Schedule.serialized
                      Schedule.firstsDist} 
             Earlier}

{ExploreBest {Compile Bridge 
                      Schedule.serialized
                      Schedule.firstsLastsDist} 
             Earlier}

{ExploreBest {Compile OptBridge 
                      Schedule.serialized
                      Schedule.firstsLastsDist} 
             Earlier}



%%
%% Solving Hard Scheduling Problems
%%

%% The Problem ABZ6
declare
ABZ6 =
abz6(tasks:
[pa(dur: 0) 
 a1(dur:62  pre:[pa] res:m7) a2(dur:24  pre:[a1] res:m8) 
 a3(dur:25  pre:[a2] res:m5) a4(dur:84  pre:[a3] res:m3) 
 a5(dur:47  pre:[a4] res:m4) a6(dur:38  pre:[a5] res:m6) 
 a7(dur:82  pre:[a6] res:m2) a8(dur:93  pre:[a7] res:m0) 
 a9(dur:24  pre:[a8] res:m9) a10(dur:66 pre:[a9] res:m1) 
 b1(dur:47  pre:[pa] res:m5) b2(dur:97  pre:[b1] res:m2) 
 b3(dur:92  pre:[b2] res:m8) b4(dur:22  pre:[b3] res:m9) 
 b5(dur:93  pre:[b4] res:m1) b6(dur:29  pre:[b5] res:m4) 
 b7(dur:56  pre:[b6] res:m7) b8(dur:80  pre:[b7] res:m3) 
 b9(dur:78  pre:[b8] res:m0) b10(dur:67 pre:[b9] res:m6) 
 c1(dur:45  pre:[pa] res:m1) c2(dur:46  pre:[c1] res:m7) 
 c3(dur:22  pre:[c2] res:m6) c4(dur:26  pre:[c3] res:m2) 
 c5(dur:38  pre:[c4] res:m9) c6(dur:69  pre:[c5] res:m0) 
 c7(dur:40  pre:[c6] res:m4) c8(dur:33  pre:[c7] res:m3) 
 c9(dur:75  pre:[c8] res:m8) c10(dur:96 pre:[c9] res:m5) 
 d1(dur:85  pre:[pa] res:m4) d2(dur:76  pre:[d1] res:m8) 
 d3(dur:68  pre:[d2] res:m5) d4(dur:88  pre:[d3] res:m9) 
 d5(dur:36  pre:[d4] res:m3) d6(dur:75  pre:[d5] res:m6) 
 d7(dur:56  pre:[d6] res:m2) d8(dur:35  pre:[d7] res:m1) 
 d9(dur:77  pre:[d8] res:m0) d10(dur:85 pre:[d9] res:m7) 
 e1(dur:60  pre:[pa] res:m8) e2(dur:20  pre:[e1] res:m9) 
 e3(dur:25  pre:[e2] res:m7) e4(dur:63  pre:[e3] res:m3) 
 e5(dur:81  pre:[e4] res:m4) e6(dur:52  pre:[e5] res:m0) 
 e7(dur:30  pre:[e6] res:m1) e8(dur:98  pre:[e7] res:m5) 
 e9(dur:54  pre:[e8] res:m6) e10(dur:86 pre:[e9] res:m2) 
 f1(dur:87  pre:[pa] res:m3) f2(dur:73  pre:[f1] res:m9) 
 f3(dur:51  pre:[f2] res:m5) f4(dur:95  pre:[f3] res:m2) 
 f5(dur:65  pre:[f4] res:m4) f6(dur:86  pre:[f5] res:m1) 
 f7(dur:22  pre:[f6] res:m6) f8(dur:58  pre:[f7] res:m8) 
 f9(dur:80  pre:[f8] res:m0) f10(dur:65 pre:[f9] res:m7) 
 g1(dur:81  pre:[pa] res:m5) g2(dur:53  pre:[g1] res:m2) 
 g3(dur:57  pre:[g2] res:m7) g4(dur:71  pre:[g3] res:m6) 
 g5(dur:81  pre:[g4] res:m9) g6(dur:43  pre:[g5] res:m0) 
 g7(dur:26  pre:[g6] res:m4) g8(dur:54  pre:[g7] res:m8) 
 g9(dur:58  pre:[g8] res:m3) g10(dur:69 pre:[g9] res:m1) 
 h1(dur:20  pre:[pa] res:m4) h2(dur:86  pre:[h1] res:m6) 
 h3(dur:21  pre:[h2] res:m5) h4(dur:79  pre:[h3] res:m8) 
 h5(dur:62  pre:[h4] res:m9) h6(dur:34  pre:[h5] res:m2) 
 h7(dur:27  pre:[h6] res:m0) h8(dur:81  pre:[h7] res:m1) 
 h9(dur:30  pre:[h8] res:m7) h10(dur:46 pre:[h9] res:m3) 
 i1(dur:68  pre:[pa] res:m9) i2(dur:66  pre:[i1] res:m6) 
 i3(dur:98  pre:[i2] res:m5) i4(dur:86  pre:[i3] res:m8) 
 i5(dur:66  pre:[i4] res:m7) i6(dur:56  pre:[i5] res:m0) 
 i7(dur:82  pre:[i6] res:m3) i8(dur:95  pre:[i7] res:m1) 
 i9(dur:47  pre:[i8] res:m4) i10(dur:78 pre:[i9] res:m2) 
 j1(dur:30  pre:[pa] res:m0) j2(dur:50  pre:[j1] res:m3) 
 j3(dur:34  pre:[j2] res:m7) j4(dur:58  pre:[j3] res:m2) 
 j5(dur:77  pre:[j4] res:m1) j6(dur:34  pre:[j5] res:m5) 
 j7(dur:84  pre:[j6] res:m8) j8(dur:40  pre:[j7] res:m4) 
 j9(dur:46  pre:[j8] res:m9) j10(dur:44 pre:[j9] res:m6)
 pe(dur:0 pre:[a10 b10 c10 d10 e10 f10 g10 h10 i10 j10])])
declare
OptABZ6 = {AdjoinAt ABZ6 constraints
           proc {$ Start Dur}
              Start.pe <: 943
           end}

%% Finding and proving optimality
{ExploreBest {Compile ABZ6
                      Schedule.serialized
                      Schedule.firstsLastsDist} 
             Earlier}

%% Proving optimality
{ExploreBest {Compile OptABZ6
                      Schedule.serialized
                      Schedule.firstsLastsDist} 
             Earlier}

{ExploreBest {Compile OptABZ6
                      Schedule.serialized
                      Schedule.taskIntervalsDistP} 
             Earlier}

%% The Problem MT10
declare
MT10 =
mt10(tasks:
[pa(dur:0)
 a1(dur:29  pre:[pa] res:m1)  a2(dur:78  pre:[a1] res:m2) 
 a3(dur: 9  pre:[a2] res:m3)  a4(dur:36  pre:[a3] res:m4) 
 a5(dur:49  pre:[a4] res:m5)  a6(dur:11  pre:[a5] res:m6) 
 a7(dur:62  pre:[a6] res:m7)  a8(dur:56  pre:[a7] res:m8) 
 a9(dur:44  pre:[a8] res:m9)  a10(dur:21 pre:[a9] res:m10) 
 b1(dur:43  pre:[pa] res:m1)  b2(dur:90  pre:[b1] res:m3) 
 b3(dur:75  pre:[b2] res:m5)  b4(dur:11  pre:[b3] res:m10) 
 b5(dur:69  pre:[b4] res:m4)  b6(dur:28  pre:[b5] res:m2) 
 b7(dur:46  pre:[b6] res:m7)  b8(dur:46  pre:[b7] res:m6) 
 b9(dur:72  pre:[b8] res:m8)  b10(dur:30 pre:[b9] res:m9) 
 c1(dur:91  pre:[pa] res:m2)  c2(dur:85  pre:[c1] res:m1) 
 c3(dur:39  pre:[c2] res:m4)  c4(dur:74  pre:[c3] res:m3) 
 c5(dur:90  pre:[c4] res:m9)  c6(dur:10  pre:[c5] res:m6) 
 c7(dur:12  pre:[c6] res:m8)  c8(dur:89  pre:[c7] res:m7) 
 c9(dur:45  pre:[c8] res:m10) c10(dur:33 pre:[c9] res:m5) 
 d1(dur:81  pre:[pa] res:m2)  d2(dur:95  pre:[d1] res:m3) 
 d3(dur:71  pre:[d2] res:m1)  d4(dur:99  pre:[d3] res:m5) 
 d5(dur: 9  pre:[d4] res:m7)  d6(dur:52  pre:[d5] res:m9) 
 d7(dur:85  pre:[d6] res:m8)  d8(dur:98  pre:[d7] res:m4) 
 d9(dur:22  pre:[d8] res:m10) d10(dur:43 pre:[d9] res:m6) 
 e1(dur:14  pre:[pa] res:m3)  e2(dur: 6  pre:[e1] res:m1) 
 e3(dur:22  pre:[e2] res:m2)  e4(dur:61  pre:[e3] res:m6) 
 e5(dur:26  pre:[e4] res:m4)  e6(dur:69  pre:[e5] res:m5) 
 e7(dur:21  pre:[e6] res:m9)  e8(dur:49  pre:[e7] res:m8) 
 e9(dur:72  pre:[e8] res:m10) e10(dur:53 pre:[e9] res:m7) 
 f1(dur:84  pre:[pa] res:m3)  f2(dur: 2  pre:[f1] res:m2) 
 f3(dur:52  pre:[f2] res:m6)  f4(dur:95  pre:[f3] res:m4) 
 f5(dur:48  pre:[f4] res:m9)  f6(dur:72  pre:[f5] res:m10) 
 f7(dur:47  pre:[f6] res:m1)  f8(dur:65  pre:[f7] res:m7) 
 f9(dur: 6  pre:[f8] res:m5)  f10(dur:25 pre:[f9] res:m8) 
 g1(dur:46  pre:[pa] res:m2)  g2(dur:37  pre:[g1] res:m1) 
 g3(dur:61  pre:[g2] res:m4)  g4(dur:13  pre:[g3] res:m3) 
 g5(dur:32  pre:[g4] res:m7)  g6(dur:21  pre:[g5] res:m6) 
 g7(dur:32  pre:[g6] res:m10) g8(dur:89  pre:[g7] res:m9) 
 g9(dur:30  pre:[g8] res:m8)  g10(dur:55 pre:[g9] res:m5) 
 h1(dur:31  pre:[pa] res:m3)  h2(dur:86  pre:[h1] res:m1) 
 h3(dur:46  pre:[h2] res:m2)  h4(dur:74  pre:[h3] res:m6) 
 h5(dur:32  pre:[h4] res:m5)  h6(dur:88  pre:[h5] res:m7) 
 h7(dur:19  pre:[h6] res:m9)  h8(dur:48  pre:[h7] res:m10) 
 h9(dur:36  pre:[h8] res:m8)  h10(dur:79 pre:[h9] res:m4) 
 i1(dur:76  pre:[pa] res:m1)  i2(dur:69  pre:[i1] res:m2) 
 i3(dur:76  pre:[i2] res:m4)  i4(dur:51  pre:[i3] res:m6) 
 i5(dur:85  pre:[i4] res:m3)  i6(dur:11  pre:[i5] res:m10) 
 i7(dur:40  pre:[i6] res:m7)  i8(dur:89  pre:[i7] res:m8) 
 i9(dur:26  pre:[i8] res:m5)  i10(dur:74 pre:[i9] res:m9) 
 j1(dur:85  pre:[pa] res:m2)  j2(dur:13  pre:[j1] res:m1) 
 j3(dur:61  pre:[j2] res:m3)  j4(dur: 7  pre:[j3] res:m7) 
 j5(dur:64  pre:[j4] res:m9)  j6(dur:76  pre:[j5] res:m10) 
 j7(dur:47  pre:[j6] res:m6)  j8(dur:52  pre:[j7] res:m4) 
 j9(dur:90  pre:[j8] res:m5)  j10(dur:45 pre:[j9] res:m8) 
 pe(dur:0 pre:[a10 b10 c10 d10 e10 f10 g10 h10 i10 j10])])
declare
OptMT10 = {AdjoinAt MT10 constraints
           proc {$ Start Dur}
              Start.pe <: 930
           end}

%% Proving optimality
{ExploreBest {Compile OptMT10
                      Schedule.serialized
                      Schedule.taskIntervalsDistP}
             Earlier}

%% Finding and proving optimality
{ExploreBest {Compile MT10
                      Schedule.serialized
                      Schedule.firstsLastsDist} 
             Earlier}




