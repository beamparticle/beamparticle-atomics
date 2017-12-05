%% @doc List Sentry organization teams
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run sentry_get_org_teams(<<"sentry">>)
%% run {json, sentry_get_org_teams(<<"sentry">>)}
%%
%% Get sentry teams for given organization
%%
%% see https://docs.sentry.io/api/teams/get-organization-teams/
%%
%% fun(OrgSlug :: binary()) -> map() | {error, term()}.
fun(OrgSlug) when is_binary(OrgSlug) ->
    %% /api/0/organizations/{organization_slug}/teams/
    SubUrl = "organizations/" ++ binary_to_list(OrgSlug) ++ "/teams/",
    sentry_make_api_get(SubUrl)
end.
