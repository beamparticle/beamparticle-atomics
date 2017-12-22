%% @doc An example gen_server worker which can its own pool
%%
%% Create a pool (pool1) with 10 workers
%% run example_create_self_gen_server_pool({create_pool, pool1, 10, pool1_id})
%%
%% IMPORTANT: The pool will not be automatically recreated when
%%            the Erlang node restarts. You should attach the create_pool
%%            call manually to your startup dynamic function.
%%            One alternative is to put it in config_setup_all_config_env/1
%%            and load it from there (or should I say reload it from there).
%%
%% IMPORTANT: The PoolWorkerId must be unique as must be
%%            PoolName.
%%
%% @see example_gen_server/1 for documentation on gen_server.
%%
%% Note: This is available since beamparticle v0.1.1+
%%
%% Use this as a template to build gen_server
%% see http://erlang.org/doc/man/gen_server.html
%% see http://erlang.org/doc/design_principles/gen_server_concepts.html
%%
fun({init}) ->
        %% Note that the keep State as proplist for standardization all across
        State = [],
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
        {ok, Data};
    %% The following variant must be used to create pool
    %% see the doc at the top.
    ({create_pool, PoolName, PoolSize, PoolWorkerId})
        when is_atom(PoolName)
        andalso is_integer(PoolSize)
        andalso is_atom(PoolWorkerId) ->

        ShutdownDelayMsec = 1000,
        MinAliveRatio = 1.0,
        ReconnectDelayMsec = 10000,
        DynamicFunctionName = <<"example_create_self_gen_server_pool">>,
        {ok, Pid} = beamparticle_dynamic:create_pool(
            PoolName, PoolSize, PoolWorkerId, ShutdownDelayMsec,
            MinAliveRatio, ReconnectDelayMsec,
            DynamicFunctionName),
        %%erlang:process_info(Pid)
        %% Pass messages to this actor as follows:
        %%beamparticle_generic_pool_worker:call(
        %%    samplepool, {<<"some message">>}, 5000)
        {ok, Pid}
end.

