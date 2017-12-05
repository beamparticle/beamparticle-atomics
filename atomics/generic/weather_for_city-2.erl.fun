%% @doc Get weather for a given city as json
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%%
%% run weather_for_city(<<"Bangalore">>, <<"india">>)
%% run {json, weather_for_city(<<"London">>, <<"uk">>)}
%%
%% run weather_for_city(<<"London">>, <<"uk">>)
%% run {json, weather_for_city(<<"London">>, <<"uk">>)}
%%
%% There are a lot of resources which can be applied to /api/, which
%% are listed in the following url.
%%
%% @see https://openweathermap.org/api
%%
%% fun(City :: binary() | string(), Country :: binary() | string()) -> map() | {error, term()}.
fun(City, Country) when is_binary(City) andalso is_binary(Country) ->
        Resource = "weather?q=" ++ binary_to_list(City) ++ "," ++ binary_to_list(Country),
        openweathermap_get_json_resource(Resource);
    (City, Country) when is_list(City) andalso is_list(Country) ->
        Resource = "weather?q=" ++ City ++ "," ++ Country,
        openweathermap_get_json_resource(Resource)
end.
