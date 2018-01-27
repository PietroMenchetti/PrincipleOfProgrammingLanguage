-module(client).
-export([start/1, main/2]).


%% the "client" sends just one msg wich is its msg and keeps listening at one port to listen the update

start([Port,Response]) ->
    io:format("SERVER Trying to bind to port ~p~n",[Port]),
    {ok, Listen} = gen_tcp:listen(Port, [binary, {packet, 0}, {reuseaddr, true}, {active, true}]),
    io:format("SERVER Listening on port ~p~n",[Port]),
    accept(Listen, Response).

accept(Listen, Response) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    respond(Socket, Response),
    accept(Listen, Response).

respond(Socket, Response) ->
    receive
        {tcp, Socket, <<"registered">>} ->
            io:format("Registration request: ~n"),
            gen_tcp:send(Socket, Response),
            respond(Socket, Response);
        {tcp, Socket, Bin} ->
            io:format("SERVER Received: ~p~n", [Bin]);
        {tcp_closed, Socket} ->
            io:format("SERVER: The client closed the connection~n")
    end.


main(Port, User)->
    spawn(client, start, [[Port, User]]).