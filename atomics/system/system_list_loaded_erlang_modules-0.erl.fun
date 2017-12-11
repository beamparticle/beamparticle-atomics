%% @doc List Erlang modules loaded in the system
%%
%% run system_list_loaded_erlang_modules()
%%
%%
fun() ->
    ModulesLoaded = lists:foldl(fun({M, _Y}, AccIn) ->
        try
            ExportedFunctions = M:module_info(exports),
            V = [list_to_binary(io_lib:format("~p:~p/~p", [M, X, Y])) || {X, Y} <- ExportedFunctions],
            MBin = atom_to_binary(M, utf8),
            [#{MBin => V} | AccIn]
        catch
            _:_ -> AccIn
        end
                end, [], code:all_loaded()),
    {json, #{<<"result">> => ModulesLoaded}}
end.

