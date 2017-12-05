%% @doc Get details of a job as identified by UuidRef
%%
%% ```
%% run jobs_get_details(<<"0b125678901234561234567890123456">>)
%% '''
%%
%% fun(JobRef :: binary()) -> {tuple(), binary(), list()}.
fun(JobRef) ->
    beamparticle_jobs:get_details(JobRef)
end.
