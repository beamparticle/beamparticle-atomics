%% @doc Convert any erlang term to printable binary
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run utils_convert_to_printable_binary(1)
%% run utils_convert_to_printable_binary("Hello")
%% run utils_convert_to_printable_binary(<<"Hello">>)
%%
%% fun(term()) -> binary().
fun(V) when is_binary(V) ->
        V;
    (V) when is_list(V) ->
        list_to_binary(V);
    (V) when is_atom(V) ->
        atom_to_binary(V, utf8);
    (V) when is_integer(V) ->
        integer_to_binary(V);
    (V) when is_float(V) ->
        float_to_binary(V, [{decimals, 4}]);
    (V) ->
        list_to_binary(io_lib:format("~p", [Msg]))
end.
