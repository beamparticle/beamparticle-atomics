%% @doc Run a (non-persistent) dynamic function only once after some delay
%%
%% ```
%% run jobs_run_once_after_n_seconds(<<"make_http_get">>, ["http://localhost:8002/k/Count"], 60)
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
%%     Args :: list(), Seconds :: integer()) -> UuidRef :: binary().
fun(DynamicFunctionName, Args, Seconds)
    when is_binary(DynamicFunctionName) andalso is_list(Args)
    andalso is_integer(Seconds) ->

    JobRef = beamparticle_jobs:add({once, Seconds}, DynamicFunctionName, Args),
    beamparticle_util:bin_to_hex_list(JobRef)
end.
