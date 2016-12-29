defmodule PrivatCursesPuller.PrivatAPI.Requesters.GetCashlessRatesTest do
  use ExUnit.Case, async: false

  import Mock

  alias PrivatCursesPuller.PrivatAPI.Requesters.GetCashlessRates
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo

  @ok_response "[{\"ccy\":\"USD\",\"base_ccy\":\"UAH\",\"buy\":\"26.20000\",\"sale\":\"27.32240\"},{\"ccy\":\"EUR\",\"base_ccy\":\"UAH\",\"buy\":\"27.40000\",\"sale\":\"28.57143\"},{\"ccy\":\"RUR\",\"base_ccy\":\"UAH\",\"buy\":\"0.42000\",\"sale\":\"0.45500\"},{\"ccy\":\"BTC\",\"base_ccy\":\"USD\",\"buy\":\"889.2250\",\"sale\":\"982.8276\"}]"

  test "returns proper list of rates infos when a response is ok" do
    with_mock HTTPotion, [get: fn(_url) -> %HTTPotion.Response{body: @ok_response} end] do
      rates_infos = GetCashlessRates.call
      assert Enum.count(rates_infos) == 4
      first_rate_info = Enum.at(rates_infos, 0)
      assert %RatesInfo{} = first_rate_info
      assert first_rate_info.ccy == "USD"
      assert first_rate_info.buy == 26.2
      assert first_rate_info.sale == 27.32240
    end 
  end
end
