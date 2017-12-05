%% @doc Get important system information
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%%
%% run system_critical_info()
%%
%% @see http://erlang.org/doc/man/erlang.html#memory-0
%%
%% Memory Types:
%% total      = processes + system
%% processes  = processes_used + ProcessesNotUsed
%% system     = atom + binary + code + ets + OtherSystem
%% atom       = atom_used + AtomNotUsed
%% RealTotal  = processes + RealSystem
%% RealSystem = system + MissedSystem
%%
%% fun() -> map().
fun() ->
    #{
        <<"uptime_sec">> => beamparticle_util:node_uptime(second),
        <<"os">> => #{
            <<"ulimit">> => #{
                <<"open_files">> => list_to_binary(string:trim(os:cmd("ulimit -n"))),
                <<"core_file_size">> => list_to_binary(string:trim(os:cmd("ulimit -c"))),
                <<"scheduling_priority">> => list_to_binary(string:trim(os:cmd("ulimit -f"))),
                <<"file_size">> => list_to_binary(string:trim(os:cmd("ulimit -n"))),
                <<"stack_size">> => list_to_binary(string:trim(os:cmd("ulimit -s")))
            }
        },
        <<"process">> => #{
            <<"count">> => erlang:system_info(process_limit),
            <<"limit">> => erlang:system_info(process_limit)
        },
        <<"stats">> => #{
            <<"active_tasks_all">> => erlang:statistics(active_tasks_all)
        },
        <<"cluster">> => #{
            <<"self">> => atom_to_binary(node(), utf8),
            <<"peers">> => [atom_to_binary(X) || X <- nodes()]
        },
        <<"atom">> => #{
            <<"atom_count">> => erlang:system_info(atom_count),
            <<"atom_limit">> => erlang:system_info(atom_limit)
        },
        <<"memory">> => maps:from_list([{atom_to_binary(X, utf8), Y} || {X,Y} <- erlang:memory()]),
        <<"garbage_collection">> => maps:from_list([{atom_to_binary(X, utf8), Y} || {X,Y} <- erlang:system_info(garbage_collection)]),
        <<"erlang">> => #{
            <<"build_type">> => atom_to_binary(erlang:system_info(build_type), utf8),
            <<"otp_release">> => list_to_binary(erlang:system_info(otp_release)),
            <<"multi_scheduling">> => atom_to_binary(erlang:system_info(multi_scheduling), utf8),
            <<"debug_compiled">> => atom_to_binary(erlang:system_info(debug_compiled), utf8),
            <<"delayed_node_table_gc">> => erlang:system_info(delayed_node_table_gc),
            <<"dirty_cpu_schedulers">> => erlang:system_info(dirty_cpu_schedulers),
            <<"dirty_cpu_schedulers_online">> => erlang:system_info(dirty_cpu_schedulers_online)
        }
    }
end.
