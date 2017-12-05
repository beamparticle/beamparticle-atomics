%% @doc List Sentry team details
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run sentry_get_team_details(<<"sentry">>, <<"neon">>)
%% run {json, sentry_get_team_details(<<"sentry">>, <<"neon">>)}
%%
%% Get sentry details for given organization and team
%%
%% see https://docs.sentry.io/api/teams/get-team-details/
%%
%% fun(OrgSlug :: binary(), TeamSlug :: binary()) -> map() | {error, term()}.
fun(OrgSlug, TeamSlug) when is_binary(OrgSlug) andalso is_binary(TeamSlug) ->
    %% /api/0/teams/{organization_slug}/{team_slug}/
    SubUrl = "teams/" ++ binary_to_list(OrgSlug) ++ "/" ++ binary_to_list(TeamSlug) ++ "/",
    sentry_make_api_get(SubUrl)
end.
