%% @doc Setup configuration variables in application environment
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run config_setup_all_config_env()
%%
%% You can pull secrets from sources like datastore (database or file)
%% as well. This function demostrates a mechanism to setup global
%% variables used by many of the other functions, say accessing
%% grafana, sentry, redis, mysql, mongodb, etc.
%%
%% fun() -> ok().
fun() ->
    Application = beamparticle,

    GrafanaConfig = [
        {base_url, "http://localhost:3000/api/"},
        {authorization, "Bearer zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzJ5WEJudlZzzzzzzzzzzzzzzzzzzzzzziwiaWQiOjF9"}
    ],
    application:set_env(Application, dynamic_config_grafana, GrafanaConfig),

    %% SMTP Client Configuration (override sys.config in beamparticle app)
    SmtpClientConfig = [
        {from_email, <<"Sender <sender@example.com>">>},
        {relay, <<"smtp.gmail.com">>},
        {username, <<"sender@example.com">>},
        {password, <<"password">>}
    ],
    application:set_env(Application, smtp_client, SmtpClientConfig),

    %% Slack configuration
    SlackConfig = [
        %% default channel
        {<<"default">>, [
            {base_url, "https://hooks.slack.com/services/AN0000001/C121321AA/HR1123232100000202002000"}
        ]}
        %% Add your other channels
    ],
    application:set_env(Application, dynamic_config_slack, SlackConfig),

    %% Openweather configuration
    OpenweatherConfig = [
        {base_url, "http://api.openweathermap.org/data/2.5/"},
        {api_key, "00000101010101010000000011111110"}
    ],
    application:set_env(Application, dynamic_config_openweather, OpenweatherConfig),

    %% Sentry configuration
    SentryConfig = [
        {base_url, "http://localhost:9000/api/0/"},
        {authorization, "Bearer zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzJ5WEJudlZzzzzzzzzzzzzzzzzzzzzzziwiaWQiOjF9"}
    ],
    application:set_env(Application, dynamic_config_sentry, SentryConfig),

    ok
end.
