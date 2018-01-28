-module(t20072017).
-export([create_dlist/1,cell/1,dlist_to_list/1,d_map/2]).

create_dlist(0) -> [];

create_dlist(N) -> [spawn(t20072017,cell,[0])] ++ create_dlist(N - 1).

d_map(Dl,F) ->
                lists:foreach(fun(W) ->
                                 W ! {(F collect(W)),set},
                                end,
                                Dl).


cell(X) -> 
        receive
            {Pid,get} -> Pid ! {self(),X},
                         cell(X);
            {Y,set} -> cell(Y)
        end.

collect(W) ->
    W ! {self(),get},
    receive
        {W,V} -> V
    end.
 

dlist_to_list(Dl) ->
                    lists:map(fun(W) ->
                                collect(W),
                                end,
                                Dl).


