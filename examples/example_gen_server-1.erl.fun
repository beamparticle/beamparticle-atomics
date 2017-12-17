%% @doc An example gen_server worker
%%
%% Note: This is available since beamparticle v0.1.1+
%%
%% Use this as a template to build gen_server
%% see http://erlang.org/doc/man/gen_server.html
%% see http://erlang.org/doc/design_principles/gen_server_concepts.html
%%
fun({init}) ->
        State = {},
        {ok, State};
    ({call, Request, From, Data}) ->
        Reply = Request,
        NewData = Data,
        {reply, Reply, NewData};
    ({cast, Request, Data}) ->
        NewData = Data,
        {noreply, NewData};
    ({info, Request, Data}) ->
        NewData = Data,
        {noreply, NewData};
    ({terminate, Reason, Data}) ->
        ok;
    ({code_change, OldVsn, Data, Extra}) ->
        {ok, Data}
end.

%%
%% Initializes the server
%% @spec ({init}) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%%
%% @spec ({call, Request :: term(), From :: {pid(), Tag :: term()}, State :: term()}) ->
%%    {reply, Reply :: term(), NewState :: #state{}} |
%%    {reply, Reply :: term(), NewState :: #state{}, timeout() | hibernate} |
%%    {noreply, NewState :: #state{}} |
%%    {noreply, NewState :: #state{}, timeout() | hibernate} |
%%    {stop, Reason :: term(), Reply :: term(), NewState :: #state{}} |
%%    {stop, Reason :: term(), NewState :: #state{}}.
%%
%% @spec ({cast, Request :: term(), State :: term()}) ->
%%    {noreply, NewState :: #state{}} |
%%    {noreply, NewState :: #state{}, timeout() | hibernate} |
%%    {stop, Reason :: term(), NewState :: #state{}}.
%% @spec ({info, Request :: term(), State :: term()}) ->
%%    {noreply, NewState :: #state{}} |
%%    {noreply, NewState :: #state{}, timeout() | hibernate} |
%%    {stop, Reason :: term(), NewState :: #state{}}.
%%
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason :: normal | shutdown | {shutdown, term()} | term(), State) -> void()
%%
%% Convert process state when code is changed
%% @spec code_change(OldVsn :: term(), State :: term(), Extra :: term()) -> {ok, NewState :: term()} | {error, Reason :: term()}.

