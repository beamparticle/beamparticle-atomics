%% @doc Send a message on default Slack channel
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run messaging_slack_send_message(<<"Hello there! I am BeamParticle. You can read more about me at http://beamparticle.org">>)
%%
%% @see https://api.slack.com/incoming-webhooks
%% @see https://api.slack.com/docs/message-formatting
%%
%% fun(binary() | iolist()) -> ok | {error, term()}.
fun(Msg) when is_list(Msg) orelse is_binary(Msg) ->
    messaging_slack_send_message(<<"default">>, Msg)
end.
