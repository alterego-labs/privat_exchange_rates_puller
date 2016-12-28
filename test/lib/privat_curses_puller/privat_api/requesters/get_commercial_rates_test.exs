defmodule PrivatCursesPuller.PrivatAPI.Requesters.GetCommercialRatesTest do
  use ExUnit.Case, async: false

  import Mock

  alias PrivatCursesPuller.PrivatAPI.Requesters.GetCommercialRates
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo

  @ok_response "[{\"exchangerate\":{\"@ccy\":\"EUR\",\"@base_ccy\":\"UAH\",\"@buy\":\"27.45311\",\"@sale\":\"27.54204\"}},{\"exchangerate\":{\"@ccy\":\"RUR\",\"@base_ccy\":\"UAH\",\"@buy\":\"0.43188\",\"@sale\":\"0.43249\"}},{\"exchangerate\":{\"@ccy\":\"USD\",\"@base_ccy\":\"UAH\",\"@buy\":\"26.28601\",\"@sale\":\"26.42937\"}},{\"exchangerate\":{\"@ccy\":\"BTC\",\"@base_ccy\":\"USD\",\"@buy\":\"860.7831\",\"@sale\":\"951.3919\"}}]"

  test "returns proper list of rates infos when a response is ok" do
    with_mock HTTPotion, [post: fn(_url, _opts) -> %HTTPotion.Response{body: @ok_response} end] do
      rates_infos = GetCommercialRates.call("token")
      assert Enum.count(rates_infos) == 4
      first_rate_info = Enum.at(rates_infos, 0)
      assert %RatesInfo{} = first_rate_info
      assert first_rate_info.ccy == "EUR"
    end 
  end
end
