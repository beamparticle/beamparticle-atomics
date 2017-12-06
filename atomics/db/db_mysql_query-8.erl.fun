%% @doc Run general query on MySQL
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% This function connects to MySQL database, runs the query
%% and then disconnects.
%%
%% @todo The MySQL pid is terminated with a kill signal, but
%%       is there any other way to terminate it?
%%
%% @todo Information like last insert id, affected rows,
%%       and warning count needs to be returned back.
%%
%% Note that timeout is 5000 millisecond in the following queries
%%
%% run db_mysql_query("localhost", 3306, "dbname", "root", "root", <<"SELECT 1">>, [], 5000)
%%
%% see https://github.com/mysql-otp/mysql-otp
%%
%% fun(Host :: string(), Port :: integer(), Database :: string(),
%%     Username :: string(), Password :: string(),
%%     Query ::  binary(),
%%     Params :: [binary()|integer()|float()],
%%     TimeoutMsec :: integer()) ->
%%         {ok, ColumnNames :: [binary()], Rows :: [ [term()] ]}
%%         | ok
%%         | {error, term()}.
fun(Host, Port, Database, Username, Password, Query, Params, TimeoutMsec) when
    is_list(Host) andalso is_integer(Port) andalso
    is_list(Username) andalso is_list(Password) andalso
    is_binary(Query) andalso is_list(Params) andalso is_integer(TimeoutMsec) ->

    {ok, Pid} = mysql:start_link([{host, Host}, {port, Port},
                                {user, Username},
                                {password, Password}, {database, Database},
                                {query_timeout, TimeoutMsec},
                                {connect_timeout, TimeoutMsec}]),
    Result = mysql:query(Pid, Query, Params),

    %% fetch more info about the last query
    %% TODO: They are not used at present, so
    %%       should we start using them?
    LastInsertId = mysql:insert_id(Pid),
    AffectedRows = mysql:affected_rows(Pid),
    WarningCount = mysql:warning_count(Pid),

    %% TODO is there any other way to terminate it?
    erlang:exit(Pid, kill),
    Result
end.
