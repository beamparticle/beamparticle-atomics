%% @doc Run general query on redis
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% Note that timeout is 5000 millisecond in the following queries
%%
%% run redis_query("localhost", 6379, ["GET", "somekey"], 5000)
%%
%% see https://github.com/wooga/eredis
%%
%% fun(Host :: string(), Port :: integer(),
%%     Command :: [iodata()], TimeoutMsec :: integer()) ->
%%         {ok, binary() | undefined} | {error, term()}.
fun(Host, Port, Command, TimeoutMsec) when
    is_list(Host) andalso is_integer(Port) andalso
    is_list(Command) andalso is_integer(TimeoutMsec) ->

    Database = 0,
    Password = "",
    ReconnectSleep = 100,
    ConnectTimeout = TimeoutMsec,
    {ok, Client} = eredis:start_link(Host, Port, Database, Password, ReconnectSleep, ConnectTimeout),
    Result = eredis:q(Client, Command),
    eredis:stop(Client),
    Result
end.
