%% @doc Get (load if required) configuration variables in application environment
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run config_get_or_load_config(dynamic_config_grafana)
%%
%% Get configuration for given type and load up everything
%% via config_setup_all_config_env/0 if none available.
%%
%% fun(atom()) -> {ok, [{atom(), term()}]} | undefined.
fun(Type) ->
    Application = beamparticle,

    case application:get_env(beamparticle, Type) of
        {ok, Config} ->
            {ok, Config};
        undefined ->
            config_setup_all_config_env(),
            application:get_env(beamparticle, Type)
    end
end.
