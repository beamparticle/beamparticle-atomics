%% @doc Send a message on Slack channel
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run slack_send_message(<<"Hello there! I am BeamParticle. You can read more about me at http://beamparticle.org">>)
%%
%% @see https://api.slack.com/incoming-webhooks
%% @see https://api.slack.com/docs/message-formatting
%%
%% fun(binary() | iolist()) -> ok | {error, term()}.
fun(Msg) when is_list(Msg) orelse is_binary(Msg) ->
    {ok, SlackConfig} = config_get_or_load_config(dynamic_config_slack),
    ApiUrl = proplists:get_value(base_url, SlackConfig),
    Json = #{
        <<"text">> => Msg
    },
    make_http_json_post(ApiUrl, jsx:encode(Json))
end.
