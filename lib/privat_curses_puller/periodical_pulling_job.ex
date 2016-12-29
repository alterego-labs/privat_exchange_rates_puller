defmodule PrivatCursesPuller.PeriodicalPullingJob do
  @moduledoc """
  Job module which will be called each tick
  """

  require Logger

  alias PrivatCursesPuller.PrivatAPI
  alias PrivatCursesPuller.NotificationsAPI
  alias PrivatCursesPuller.Core.RatesProcessor

  @doc """
  Calls job
  """
  @spec call :: none
  def call do
    Logger.info "PeriodicalPullingJob called..."
    cashless_rates = PrivatAPI.get_cashless_rates
    auth_info = PrivatAPI.auth_commercial_api(client_id, client_secret)
    commercial_rates = PrivatAPI.get_commercial_rates(auth_info.id)
    notification_info = RatesProcessor.call(commercial_rates, cashless_rates)
    notify_clients(notification_info)
  end

  defp notify_clients(notification_info) do
    fetch_available_notifiers
    |> Enum.each(&(NotificationsAPI.notify(&1, notification_info)))
  end

  defp client_id do
    Keyword.get(privat_api_envs, :client_id)
  end

  defp client_secret do
    Keyword.get(privat_api_envs, :client_secret)
  end

  defp privat_api_envs do
    Application.get_env :privat_curses_puller, :privat_api
  end

  defp fetch_available_notifiers do
    Application.get_env(:privat_curses_puller, :notifiers)
  end
end
