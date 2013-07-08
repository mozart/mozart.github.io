%%%
%%% Chapter: Writing Problem Solvers in Oz
%%%

%%
%% DONALD + GERALD = ROBERT
%%

declare
proc {Donald Root}
   sol(a:A b:B d:D e:E g:G l:L n:N  o:O r:R t:T) = Root
in
   Root ::: 0#9
   {FD.distinct Root}
   D\=:0  R\=:0  G\=:0
      100000*D + 10000*O + 1000*N + 100*A + 10*L + D
   +  100000*G + 10000*E + 1000*R + 100*A + 10*L + D
   =: 100000*R + 10000*O + 1000*B + 100*E + 10*R + T
   {FD.distribute split Root}
end

{ExploreAll Donald}



%%%
%%% Chapter: Propagators for Redundant Constraints
%%%

%%
%% Magic Sequence
%%

declare
fun {MagicSequence N}
   Cs = {List.number ~1 N-2 1}
in
   proc {$ S}
      {FD.tuple sequence N 0#N-1 S}
      {For 0 N-1 1 
       proc {$ I} {FD.exactly S.(I+1) S I} end}
      %% redundant constraints
      {FD.sum S '=:' N}
      {FD.sumC Cs S '=:' 0}
      %%
      {FD.distribute ff S}
   end
end

{ExploreAll {MagicSequence 14}}



