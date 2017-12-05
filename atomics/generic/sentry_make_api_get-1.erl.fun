%% @doc Make HTTP GET on Sentry for a resource
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run sentry_make_api_get(<<"teams/sentry/neon/projects/">>)
%% run sentry_make_api_get("teams/sentry/neon/projects/")
%% run {json, sentry_make_api_get(<<"teams/sentry/neon/projects/">>)}
%%
%% Get sentry information via /api/0/ base url.
%%
%% see https://docs.sentry.io/api/
%%
%% fun(SubUrl :: binary() | string()) -> {ok, map()} | {error, term()}.
fun(SubUrl) when is_binary(SubUrl) orelse is_list(SubUrl) ->
    {ok, SentryConfig} = config_get_or_load_config(dynamic_config_sentry),
    BaseUrl = proplists:get_value(base_url, SentryConfig),
    Auth = proplists:get_value(authorization, SentryConfig),
    Headers = [{"Authorization", Auth},
               {"Accept", "application/json"}],
    Url = case is_binary(SubUrl) of
            true ->
                BaseUrl ++ binary_to_list(SubUrl);
            false ->
                BaseUrl ++ SubUrl
        end,
    case make_http_get(Url, Headers) of
        {ok, Body} ->
            #{<<"result">> => jsx:decode(Body, [return_maps])};
        E ->
            E
    end
end.
