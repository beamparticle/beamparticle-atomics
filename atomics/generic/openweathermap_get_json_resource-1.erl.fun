%% @doc Get json resource from openweathermap
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%%
%% run openweathermap_get_json_resource(<<"weather?q=London,uk">>)
%% run {json, openweathermap_get_json_resource(<<"weather?q=London,uk">>)}
%%
%% @see https://openweathermap.org/api
%% @see https://openweathermap.org/appid#use
%% @see https://openweathermap.org/current#name
%%
%% fun(Resource :: binary()) -> map() | {error, term()}.
fun(Resource) when is_binary(Resource) orelse is_list(Resource) ->
    {ok, OpenweatherConfig} = config_get_or_load_config(dynamic_config_openweather),
    ApiKey = proplists:get_value(api_key, OpenweatherConfig),
    BaseUrl = proplists:get_value(base_url, OpenweatherConfig),
    ResourceString = case is_binary(Resource) of
                        true ->
                            binary_to_list(Resource);
                        false ->
                            Resource
                    end,
    Url = BaseUrl ++ ResourceString ++ "&APPID=" ++ ApiKey,
    case make_http_get(Url) of
        {ok, Body} ->
            #{<<"result">> => jsx:decode(Body, [return_maps])};
        E ->
            E
    end
end.
