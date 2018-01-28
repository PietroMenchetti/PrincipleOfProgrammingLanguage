-module(t20072017).
-export([create_dlist/1,cell/1,dlist_to_list/1,D_map/1]).

create_dlist(0) -> [];

create_dlist(N) -> [spawn(t20072017,cell,[0])] ++ create_dlist(N - 1).

cell(X) -> 
        receive
            {Pid,get} -> Pid ! {self(),X},
                         cell(X);
            {Y,set} -> cell(Y)
        end.

dlist_to_list(Dl) ->
                    lists:map(fun(W) ->
                                W ! {self(),get},
                                receive
                                    {W,V} -> V
                                end,
                                Dl).

D_map(Dl,F) ->
                lists:foreach(fun(W) ->
                                W ! {self(),get},
                                receive
                                    {W,V} -> W ! {(F V),set}
                                end,
                                Dl).