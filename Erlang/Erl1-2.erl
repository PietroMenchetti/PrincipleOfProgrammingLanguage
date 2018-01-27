Erlang

    is dynamic type

Tuples

    {123, def, abc}

Pattern matching

    {A,_, [B|_], {B}} = {abc, 23, [22, x], {22}} 

    Succeeds - binds A = abc, B = 22 

Function

    define function <namemodule> : <namefunction> (Arg1, ... Argn)
    A function is defined as a sequence of clauses.
        func(Pattern1, Pattern2, ...) -> ... ;
        func(Pattern1, Pattern2, ...) -> ... ;
        ...
        func(Pattern1, Pattern2, ...) -> ... .
    Variables are local to each clause, and are allocated and deallocated
    automatically

    factorial(0) -> 1;
    factorial(N) -> N * factorial(N-1).

    area({square, Side}) ->
        Side * Side;
    area({circle, Radius}) ->
        3.14 * Radius * Radius;
    area({triangle, A, B, C}) ->
        S = (A + B + C)/2,
        math:sqrt(S*(S-A)*(S-B)*(S-C));
    area(Other) ->
        {invalid_object, Other}.

Module

    define explict the function that i want to export
    every time i want to use function i also put the name of the Module
    there is a preprocessor, and everything that starts with '-' it is for the preprocessor
    -export([double/1]). export double wich is function that takes 1 argument
    double(X) ->
        times(X, 2).     multiplies x by 2
    times(X, N) ->
        X * N.
    

BIFS built in functions
    
    implemented in C

    date()
    time()
    length([1,2,,34])
    size({a,b,c})
    
Erlang is call by value

Guarded Function clauses

    factorial(0) -> 1;
    factorial(N) when N > 0 ->      when is like | in haskell
            N * factorial(N - 1).

    i cannot use a function defined by me that returns a boolean
    there are some functions that i can use with when

    everytime i evaluate a pattern terminates!!! caused by the constraints given by the language
Apply

    apply(Mod, Func, Args)
    apply(?MODULE, min_max, [[4,1,7,3,9,10]]). min_max takes one arg,
    ?MODULE uses the preprocessor to get the current module’s name

If then else 

Lambdas and high order function

    We can use it like this: Square(3).
    Square = fun (X) -> X*X
    
    Lambdas can be passed as usual to higher order functions:
    lists:map(Square, [1,2,3]).        returns [1,4,9]
    
    To pass standard (i.e. "non-lambda") functions, we need to prefix their name
    with fun and state its arity:
    lists:foldr(fun my_function/2, 0, [1,2,3]). 

Concurrent Programming

    entity = actor are Concurrent
    actors can comunicate through messages
    actors can be created dynamic

    actor representing a process in the Erlang system
    everything is scheduled by the VM

    three main primitives :
    -spawn tkaes a function, args and create a process that runs that code
    spawn returns a process identifier used to send messages
    -send sends a message to a process throught its identifier the content of the message is a variable the operation is async
    
    we have a process with Pid1 (Process Identity or Pid)
    
    - Pid2 = spawn(Mod, Func, Args) is like apply
    after, Pid2 is the process identifier of the new process – this is known only to
    process Pid1.

    Process A sends a message to B (it uses self() to retrive its Pid)
    - PidB ! {self(), foo}

    B receives it with
    
    - receive                           it's blocking until it find something that matches, looks for the first msg that matches
        {From, Msg} -> Actions
    - end

    receive
        {A, {mymessage, D}} -> work_on_data(D);
    end

-module(echo).
-export([go/0, loop/0]).

go() ->
    Pid2 = spawn(echo, loop, []),
    Pid2 ! {self(), hello},
    receive
        {Pid2, Msg} ->                      {Pid2, Msg} receives only for Pid2
            io:format("P1 ~w~n",[Msg])
    end,
Pid2 ! stop.


loop() ->
    receive
        {From, Msg} ->
            From ! {self(), Msg},      send to From 
            loop();
        stop ->
            true
    end.


Registered Processes

start() ->
    Pid = spawn(?MODULE, server, [])
    register(analyzer, Pid).      saves the Pid into a variable like analyzer

    analyze(Seq) ->
        analyzer ! {self(), {analyze, Seq}},
    receive
        {analysis_result, R} -> R
    end.

Client-Server can be easily realized through a simple protocol, where requests
have the syntax {request, ...}, while replies are written as {reply, ...}

-module(myserver).
    server(Data) -> % note: local data sever Data represents the local data of the server
    receive
        {From,{request,X}} ->
            {R, Data1} = fn(X, Data),
            From ! {myserver,{reply, R}},
            server(Data1)       recalling the server function with the new "state" the new local data computed after fn
        end.

 Interface Library to implement the protocol between server and client

-export([request/1]).
request(Req) ->
    myserver ! {self(),{request,Req}},   myserver is registered
    receive
        {myserver,{reply,Rep}} -> Rep
    end.

Timeouts

receive
    foo -> Actions1;
after
    Time -> Actions2;

If the message foo is received from A within the time Time perform Actions1
otherwise perform Actions2.

flush() – flushes the message buffer

just provide call back function for the application

crashing as soon as possible

support to code hot-swap: processes running the old version of application
                          processes running the new version of application
 
"Let it crash": an example


supervisior linked to a number of workers
1 We are going to see a simple supervisor linked to a number of workers.
2 Each worker has a state (a natural number, 0 at start), can receive messages
with a number to add to it from the supervisor, and sends back its current
state. When its local value exceeds 30, a worker ends its activity.
3 The supervisor sends "add" messages to workers, and keeps track of how
many of them are still active; when the last one ends, it terminates.
4 We are going to add code to simulate random errors in workers: the
supervisor must keep track of such problems and re-start a new worker if one
is prematurely terminated


main(Count) ->
    register(the_master, self()), % I’m the master, now
    start_master(Count),
    unregister(the_master),
    io:format("That’s all.~n").

start_master(Count) ->
    % The master needs to trap exits:
    process_flag(trap_exit, true),
    create_children(Count),
    master_loop(Count).

% This creates the linked children
create_children(0) -> ok;
create_children(N) ->
        Child = spawn_link(?MODULE, child, [0]), % spawn + link
        io:format("Child ~p created~n", [Child]),
        Child ! {add, 0},
        create_children(N-1).


master_loop(Count) ->
    receive
        {value, Child, V} ->
            io:format("child ~p has value ~p ~n", [Child, V]),
            Child ! {add, rand:uniform(10)},
            master_loop(Count);
        {’EXIT’, Child, normal} ->                  'EXIT' is a special symbol received by the VM when a child died, this process_flag(trap_exit, true) says to the VM to inform the master wheter
            io:format("child ~p has ended ~n", [Child]),
            if
                Count =:= 1 -> ok; % this was the last
                true -> master_loop(Count-1)
            end;
        {’EXIT’, Child, _} -> % "unnormal" termination
            NewChild = spawn_link(?MODULE, child, [0]),
            io:format("child ~p has died, now replaced by ~p ~n",
                        [Child, NewChild]),
            NewChild ! {add, rand:uniform(10)},
            master_loop(Count)
end.


child(Data) ->
    receive
        {add, V} ->
            NewData = Data+V,
            BadChance = rand:uniform(10) < 2,
            if
                % random error in child:
                BadChance -> error("I’m dying");
                % child ends naturally:
                NewData > 30 -> ok;
                % there is still work to do:
                true -> the_master ! {value, self(), NewData},
                        child(NewData)
            end
end.














