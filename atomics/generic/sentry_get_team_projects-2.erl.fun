%% @doc List Sentry team projects
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run sentry_get_team_projects(<<"sentry">>, <<"neon">>)
%% run {json, sentry_get_team_projects(<<"sentry">>, <<"neon">>)}
%%
%% Get sentry projects for given organization and team
%%
%% see https://docs.sentry.io/api/teams/get-team-project-index/
%%
%% fun(OrgSlug :: binary(), TeamSlug :: binary()) -> map() | {error, term()}.
fun(OrgSlug, TeamSlug) when is_binary(OrgSlug) andalso is_binary(TeamSlug) ->
    %% /api/0/teams/{organization_slug}/{team_slug}/projects/
    ListTeamProjects = "teams/" ++ binary_to_list(OrgSlug) ++ "/" ++ binary_to_list(TeamSlug) ++ "/projects/",
    sentry_make_api_get(ListTeamProjects)
end.
