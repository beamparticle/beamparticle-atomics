%% @doc HTTP GET on the given url with headers and return results
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% Issue HTTP GET and return success on http code 200.
%%
%% fun(binary() | string(), [{binary(), binary()}]) -> {ok, binary()} | {error, term()}.
fun(Url, Headers) when is_binary(Url) andalso is_list(Headers) ->
    case httpc:request(get, {binary_to_list(Url), Headers}, [], [{body_format, binary}]) of
      {ok, {{_, 200, _}, _Headers, Body}} ->
          {ok, Body};
      Resp ->
          {error, Resp}
    end;
    (Url, Headers) when is_list(Url) andalso is_list(Headers) ->
        case httpc:request(get, {Url, Headers}, [], [{body_format, binary}]) of
            {ok, {{_, 200, _}, _Headers, Body}} ->
                {ok, Body};
            Resp ->
                {error, Resp}
        end
end.
