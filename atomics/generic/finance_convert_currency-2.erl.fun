%% @doc Gives the currency conversion rate between two currencies as of today
%% @author Neeraj Sharma <neeraj.sharma@alumni.iitg.ernet.in>
%%
%% run finance_convert_currency(<<"USD">>, <<"INR">>)
%%
%% fun(FromCurrency :: binary(), ToCurrency :: binary()) ->
%%     map() | {error, term()}.
fun(FromCurrency, ToCurrency) when is_binary(FromCurrency)
    andalso is_binary(ToCurrency) ->
    BaseUrl = "https://api.fixer.io/latest?symbols=",
    Url = BaseUrl ++ binary_to_list(FromCurrency) ++ "," ++ binary_to_list(ToCurrency),
    case make_http_get(Url) of
        {ok, Body} ->
            %% #{<<"base">> => <<"EUR">>,<<"date">> => <<"2017-12-01">>, <<"rates">> => #{<<"INR">> => 76.655,<<"USD">> => 1.1885}}
            Map = jsx:decode(Body, [return_maps]),
            MapRates = maps:get(<<"rates">>, Map),
            #{
                FromCurrency := FromCurrencyRateFromBase,
                ToCurrency := ToCurrencyRateFromBase
            } = MapRates,
            Rate = ToCurrencyRateFromBase / FromCurrencyRateFromBase,
            #{
                <<"from_currency">> => FromCurrency,
                <<"to_currency">> => ToCurrency,
                <<"rate">> => Rate
            };
        E ->
            E
    end
end.
