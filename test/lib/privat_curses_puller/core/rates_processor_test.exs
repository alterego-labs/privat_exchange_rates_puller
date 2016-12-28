defmodule PrivatCursesPuller.Core.RatesProcessorTest do
  use ExUnit.Case, async: true

  alias PrivatCursesPuller.Core.{RatesProcessor, RatesNotificationInfo}
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo

  setup_all do
    commercial_rates = [
      %RatesInfo{ccy: "EUR", base_ccy: "UAH", buy: 27.45311, sale: 27.54204},
      %RatesInfo{ccy: "USD", base_ccy: "UAH", buy: 26.28, sale: 26.43}
    ]
    cashless_rates = [
      %RatesInfo{ccy: "USD", base_ccy: "UAH", buy: 26.4, sale: 27.23},
      %RatesInfo{ccy: "EUR", base_ccy: "UAH", buy: 27.8, sale: 28.4}
    ]
    info_struct = RatesProcessor.call(commercial_rates, cashless_rates) 
    {:ok, %{processor_result: info_struct}}
  end

  test "call returns proper type of struct", %{processor_result: processor_result} do
    assert %RatesNotificationInfo{} = processor_result
  end

  test "call calcs ratio properly", %{processor_result: processor_result} do
    assert processor_result.ratio == 3.489
  end
end
