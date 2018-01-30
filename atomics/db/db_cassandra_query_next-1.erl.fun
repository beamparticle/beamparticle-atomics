%% @doc Get next page of result for a cassandra query
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run db_cassandra_query_next(Context)
%%
%%
%% Note that when this function returns empty Rows
%% it indicates that there are no more pages.
%%
%% see https://github.com/matehat/cqerl
%%
%% fun(Context :: term()) ->
%%         {ok, Rows :: list(), Context :: term()} | {error, term()}.
fun(Context) ->
    case cqerl:has_more_pages(Context) of
        true ->
            case cqerl:fetch_more(Context) of
                {ok, Context2} ->
                    Rows = cqerl:all_rows(Context2),
                    {ok, Rows, Context2};
                E ->
                    E
            end;
        false ->
            {ok, [], Context}
    end
end.
