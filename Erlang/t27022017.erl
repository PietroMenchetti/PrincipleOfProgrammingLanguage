-module(t27022017).
-export([mfilter/2,checker/3]).

mfilter(L,P) ->
        W = lists:map( fun (X)
                            -> spawn(t27022017,checker,[self(),X,P]) 
                        end, L),
        lists:foldl( fun(X,Y)
                            -> receive
                                {X,true,V} -> [V] ++ Y
                                {X,false} -> Y
                                end, [] W).

checker(Pid,X,P) ->
        case (P X) of
            true -> Pid ! {self(),true,X}
            false -> Pid ! {self(),false}
        end.