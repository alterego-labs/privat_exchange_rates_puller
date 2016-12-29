defmodule PrivatCursesPuller.PrivatAPI do
  alias PrivatCursesPuller.PrivatAPI.AuthInfo
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo
  alias PrivatCursesPuller.PrivatAPI.Requesters.{GetCashlessRates, AuthCommercialApi, GetCommercialRates}

  @doc """
  Requests and provides cashless exchange rates information
  """
  @spec get_cashless_rates :: [RatesInfo.t]
  def get_cashless_rates do
    GetCashlessRates.call
  end

  @doc """
  Makes a request to sign in into a commercial API
  """
  @spec auth_commercial_api(String.t, String.t) :: AuthInfo.t
  def auth_commercial_api(client_id, client_secret) do
    AuthCommercialApi.call(client_id, client_secret)
  end

  @doc """
  Requests and provides commercial exchange rates information.

  _WARNING:_ To be able to use this API method you have to authorize using `PrivatAPI.auth_commercial_api/2` method.
  """
  @spec get_commercial_rates(String.t) :: [RatesInfo.t]
  def get_commercial_rates(token) do
    GetCommercialRates.call(token)
  end
end
