%% @doc Run general query on cassandra
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% Note that timeout is 5000 millisecond in the following queries
%%
%% run db_cassandra_query("localhost", 9042, [], <<"SELECT * from users">>, [], 5000)
%%
%% run db_cassandra_query("localhost", 9042, [{protocol_version, 3}], <<"SELECT * from users">>, [], 5000)
%% run db_cassandra_query("localhost", 9042, [{auth, {cqerl_auth_plain_handler, [ {"username", "password"} ]}}], <<"SELECT * from users">>, [], 5000)
%%
%% see https://github.com/matehat/cqerl
%%
%% Note that the Rows returned is an Erlang proplist.
%% Additionally, Context must be used for get next page of results.
%%
%%
%% fun(Host :: string(), Port :: integer(),
%%     DbOpts :: list(),
%%     Query :: iodata(), Params :: list() | map(),
%%     TimeoutMsec :: integer()) ->
%%         {ok, Rows :: list(), Context :: term()} | {error, term()}.
fun(Host, Port, DbOpts, Query, Params, TimeoutMsec) when
    is_list(Host) andalso is_integer(Port) andalso
    is_list(DbOpts) andalso
    (is_binary(Query) orelse is_list(Query)) andalso
    is_integer(TimeoutMsec) ->

    case cqerl:get_client({Host, Port}, DbOpts) of
        {ok, Client} ->
            Reusable = undefined,
            Named = false,
            PageSize = 100,
            PageState = undefined,
            Consistency = one,
            SerialConsistency = undefined,
            ValueEncodeHandler = undefined,
            CqrlQuery = {cql_query, Query, Params, Reusable,
                         Named, PageSize, PageState,
                         Consistency, SerialConsistency,
                         ValueEncodeHandler},
            case cqerl:run_query(Client, CqrlQuery) of
                {ok, Result} ->
                    Rows = cqerl:all_rows(Result),
                    {ok, Rows, Result};
                E ->
                    E
            end;
        E2 ->
            E2
    end
end.
