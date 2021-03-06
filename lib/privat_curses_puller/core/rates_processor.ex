defmodule PrivatCursesPuller.Core.RatesProcessor do
  @moduledoc """
  Calculates ratio between sale and buy rates.
  """

  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo
  alias PrivatCursesPuller.Core.RatesNotificationInfo

  @doc """
  Calls rates processor
  """
  @spec call([RatesInfo.t], [RatesInfo.t]) :: RatesNotificationsInfo.t
  def call(commercial_rates, cashless_rates) do
    target_ccy = fetch_target_ccy
    target_commercial_rate = fetch_for_target_ccy(commercial_rates, target_ccy)
    target_cashless_rate = fetch_for_target_ccy(cashless_rates, target_ccy)
    
    sale_rate = target_commercial_rate.buy
    buy_rate = target_cashless_rate.sale
    ratio = calc_ratio(sale_rate, buy_rate)

    %RatesNotificationInfo{
      ccy: target_ccy,
      sale: sale_rate,
      buy: buy_rate,
      ratio: ratio
    }
  end

  defp fetch_for_target_ccy(rates, target_ccy) do
    rates
    |> Enum.find(fn(rate_info) -> rate_info.ccy == target_ccy end)
  end

  defp calc_ratio(sale_rate, buy_rate) do
    ratio = (1 - (sale_rate / buy_rate)) * 100
    Float.round(ratio, 3)
  end

  defp fetch_target_ccy do
    Application.get_env(:privat_curses_puller, :target_ccy)
  end
end
