defmodule PrivatCursesPuller.Core.CursesProcessor do
  @moduledoc """
  Calculates ratio between sale and buy curses.
  """

  alias PrivatCursesPuller.PrivatAPI.{CurseInfo}
  alias PrivatCursesPuller.Core.CursesNotificationInfo

  @target_ccy "USD"

  @doc """
  Calls curses processor
  """
  @spec call([CurseInfo.t], [CurseInfo.t]) :: CursesNotificationInfo.t
  def call(commercial_curses, cashless_curses) do
    target_commercial_curse = fetch_for_target_ccy(commercial_curses, @target_ccy)
    target_cashless_curse = fetch_for_target_ccy(cashless_curses, @target_ccy)
    
    sale_curse = target_commercial_curse.buy
    buy_curse = target_cashless_curse.sale
    ratio = (1 - (sale_curse / buy_curse)) * 100

    %CursesNotificationInfo{
      ccy: @target_ccy,
      sale: sale_curse,
      buy: buy_curse,
      ratio: ratio
    }
  end

  defp fetch_for_target_ccy(curses, target_ccy) do
    curses
    |> Enum.filter(fn(curse_info) -> curse_info.ccy == target_ccy end)
  end
end
