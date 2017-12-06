%% @doc Send a message on Slack channel
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run messaging_slack_send_message(<<"default">>, <<"Hello there! I am BeamParticle. You can read more about me at http://beamparticle.org">>)
%%
%% @see https://api.slack.com/incoming-webhooks
%% @see https://api.slack.com/docs/message-formatting
%%
%% fun(Channel :: binary(), Msg :: binary() | iolist()) -> ok | {error, term()}.
fun(Channel, Msg) when when is_binary(Channel)
    andalso (is_list(Msg) orelse is_binary(Msg)) ->

    {ok, SlackConfig} = config_get_or_load_config(dynamic_config_slack),
    ChannelConfig = proplists:get_value(Channel, SlackConfig),
    ApiUrl = proplists:get_value(base_url, ChannelConfig),
    Json = #{
        <<"text">> => Msg
    },
    transport_make_http_json_post(ApiUrl, jsx:encode(Json))
end.
