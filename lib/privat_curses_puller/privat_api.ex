defmodule PrivatCursesPuller.PrivatAPI do
  alias PrivatCursesPuller.PrivatAPI.AuthInfo
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo
  alias PrivatCursesPuller.PrivatAPI.Requesters.{GetCashlessRates}

  @doc """
  Requests and provides cashless exchange rates information
  """
  @spec get_cashless_curses :: [RatesInfo.t]
  def get_cashless_curses do
    GetCashlessRates.call
  end

  @spec auth_commercial_api(String.t, String.t) :: AuthInfo.t
  def auth_commercial_api(client_id, client_secret) do
    
  end

  @spec get_commercial_curses(String.t) :: [RatesInfo.t]
  def get_commercial_curses(token) do
    
  end
end
