%% @doc Send an email to a given user email as per RFC 2822
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%%
%% Note that email address must follow
%% RFC 2822 section 3.4 Address Specification.
%%
%% address         =       mailbox / group
%% mailbox         =       name-addr / addr-spec
%% name-addr       =       [display-name] angle-addr
%% angle-addr      =       [CFWS] "<" addr-spec ">" [CFWS] / obs-angle-addr
%% group           =       display-name ":" [mailbox-list / CFWS] ";"
%%                         [CFWS]
%% display-name    =       phrase
%% mailbox-list    =       (mailbox *("," mailbox)) / obs-mbox-list
%% address-list    =       (address *("," address)) / obs-addr-list
%%
%%
%% run email_send_plain_message(<<"Beamer <beamer@beamparticle.org>">>, <<"Hello">>, <<"Hello there! I live at http://beamparticle.org">>)
%%
%% IMPORTANT: Email could be throttled, so use them wisely.
%%
%% fun(UserEmail :: binary(), Subject :: binary(),
%%     Body :: binary()) -> {ok, term()} | {error, term()}.
fun(UserEmail, Subject, Body) when is_binary(UserEmail)
    andalso is_binary(Subject) andalso is_binary(Body) ->

    beamparticle_smtp_util:send_plain_email([UserEmail], Subject, Body)
end.
