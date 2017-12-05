%% @doc HTTP GET on the given url and return results
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% Issue HTTP GET and return success on http code 200.
%%
%% fun(binary() | string()) -> {ok, binary()} | {error, term()}.
fun(Url) when is_binary(Url) ->
    case httpc:request(get, {binary_to_list(Url), []}, [], [{body_format, binary}]) of
      {ok, {{_, 200, _}, _Headers, Body}} ->
          {ok, Body};
      Resp ->
          {error, Resp}
    end;
    (Url) when is_list(Url) ->
        case httpc:request(get, {Url, []}, [], [{body_format, binary}]) of
            {ok, {{_, 200, _}, _Headers, Body}} ->
                {ok, Body};
            Resp ->
                {error, Resp}
        end
end.
