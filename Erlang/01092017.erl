-module(parfind).
-compile(export_all).

parfind(L,X) -> 
    W = [spawn(?module,worker,[Y,X,self()]) || Y <- L],
    get_result(W).
    

get_result([]) ->
        boh;

get_result([X|XS]) ->
    receive
        {X,true,L} -> L
        {X,false} -> get_result(XS)
    end.

worker(L,X,P) ->
    case lists:member(X,L) of
    true -> P ! {self(),true,L}
    false -> P ! {self(),false}
    end.