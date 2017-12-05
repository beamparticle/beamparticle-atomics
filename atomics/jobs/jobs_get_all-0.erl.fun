%% @doc Get all the jobs currently configured in the system
%%
%% ```
%% run jobs_get_all()
%% '''
%%
%% Get all the jobs UuidRef which are configured within the system.
%%
%% fun() -> [binary()].
fun() ->
    beamparticle_jobs:all()
end.
