%% @doc Run a dynamic function as per schedule
%%
%% Run a non-persistent (which do not auto-load when
%% system restarts) once only at 3:30pm localtime of
%% the server.
%%
%% ```
%% run jobs_run_schedule(<<"make_http_get">>, ["http://localhost:8002/k/Count"], {once, {3, 30, pm}}, false)
%% '''
%%
%% Run a persistent (which auto-loads when
%% system restarts) once only at 3:30pm localtime of
%% the server.
%%
%% ```
%% run jobs_run_schedule(<<"make_http_get">>, ["http://localhost:8002/k/Count"], {once, {3, 30, pm}}, true)
%% '''
%%
%% Reference specifications for schedule is as follows:
%%
%% ```
%% {once, {3, 30, pm}}
%% {once, {12, 23, 32}}
%% {once, 3600}
%% {daily, {every, {23, sec}, {between, {3, pm}, {3, 30, pm}}}}
%% {daily, {3, 30, pm}}
%% {daily, [{1, 10, am}, {1, 07, 30, am}]}
%% {weekly, thu, {2, am}}
%% {weekly, wed, {2, am}}
%% {weekly, fri, {2, am}}
%% {monthly, 1, {2, am}}
%% {monthly, 4, {2, am}}
%% '''
%%
%% fun(DynamicFunctionName :: binary(),
%%     Args :: list(), Schedule :: tuple(),
%%     Persistent :: boolean()) -> UuidRef :: binary().
fun(DynamicFunctionName, Args, Schedule, Persistent)
    when is_binary(DynamicFunctionName) andalso is_list(Args)
    andalso is_tuple(Schedule) andalso is_boolean(Persistent) ->

    JobRef = beamparticle_jobs:add(Schedule, DynamicFunctionName, Args, Persistent),
    beamparticle_util:bin_to_hex_list(JobRef)
end.
