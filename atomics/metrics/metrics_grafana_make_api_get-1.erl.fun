%% @doc Make HTTP GET on Grafana for a resource
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% Get home dashboard
%% run metrics_grafana_make_api_get("dashboards/home")
%% run {json, metrics_grafana_make_api_get("dashboards/home")}
%%
%% Get critical business api dashboard
%% run metrics_grafana_make_api_get("dashboards/db/critical-business-apis")
%% run {json, metrics_grafana_make_api_get("dashboards/db/critical-business-apis")}
%%
%% Get all dashboards
%% run {json, metrics_grafana_make_api_get("search?query=&starred=false")}
%%
%%
%% ONLY WORKS FOR ADMIN TOKEN
%% run metrics_grafana_make_api_get(<<"datasources">>)
%% run metrics_grafana_make_api_get("datasources")
%% run {json, metrics_grafana_make_api_get("datasources")}
%% run metrics_grafana_make_api_get(<<"datasources/name/DalmatinerDB">>)
%%
%% http://docs.grafana.org/http_api/data_source/#data-source-proxy-calls
%%
%% Directly query DalmatinerDB proxy (sample):
%% QueryString = beamparticle_urlutils:escape_uri(<<"SELECT sum(sum(replace_below_confidence('sys'.'event'.'count' FROM 'prod' WHERE 'etype' = 'event' AND 'esubtype' = 'success', 0.9, 0.0)), 2m) AS successful BEFORE "2017-11-30 07:44:12" FOR 47653s">>),
%% grafana_make_api_get("datasources/proxy/1/?q=" ++ QueryString)
%%
%% Notes:
%%   * resolution - Value in millisecond
%%   * start - Start time in Epoch millisecond
%%   * name - Name as in request query
%%
%% Response: {"metadata":{},"name":"'successful'","resolution":120000,"type":"metrics","values":[4.6, ...]}],"start":1511980199000}
%%
%% For Multi Series response:
%% Response: {"query_time":128514,"results":[{"metadata":{},"name":"'metric-1'","resolution":120000,"type":"metrics","values":[9.3,...]},{"metadata":{},"name":"'metric-2'","resolution":120000,"type":"metrics","values":[1.01, ...]}],"start":1511980199000}
%%
%%
%% Get grafana information via /api/ base url.
%%
%% see http://docs.grafana.org/http_api/
%% http://docs.grafana.org/http_api/data_source/
%%
%% fun(SubUrl :: binary() | string()) -> map() | {error, term()}.
fun(SubUrl) when is_binary(SubUrl) orelse is_list(SubUrl) ->
    {ok, GrafanaConfig} = config_get_or_load_config(dynamic_config_grafana),
    BaseUrl = proplists:get_value(base_url, GrafanaConfig),
    Auth = proplists:get_value(authorization, GrafanaConfig),
    Headers = [{"Authorization", Auth},
               {"Accept", "application/json"}],
    Url = case is_binary(SubUrl) of
            true ->
                BaseUrl ++ binary_to_list(SubUrl);
            false ->
                BaseUrl ++ SubUrl
        end,
    case transport_make_http_get(Url, Headers) of
        {ok, Body} ->
            #{<<"result">> => jsx:decode(Body, [return_maps])};
        E ->
            E
    end
end.
