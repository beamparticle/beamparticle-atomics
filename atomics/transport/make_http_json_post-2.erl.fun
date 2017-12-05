%% @doc HTTP POST on the given url with body as json and return results
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% Issue HTTP POST with body as json and return success on http code 200.
%%
%% fun(binary() | string(), iolist() | binary()) -> {ok, binary()} | {error, term()}.
fun(Url, Msg) when is_binary(Url) ->
    case httpc:request(post, {binary_to_list(Url), [], "application/json", Msg}, [], [{body_format, binary}]) of
      {ok, {{_, 200, _}, _Headers, Body}} ->
          {ok, Body};
      Resp ->
          {error, Resp}
    end;
    (Url, Msg) when is_list(Url) ->
        case httpc:request(post, {Url, [], "application/json", Msg}, [], [{body_format, binary}]) of
            {ok, {{_, 200, _}, _Headers, Body}} ->
                {ok, Body};
            Resp ->
                {error, Resp}
        end
end.
