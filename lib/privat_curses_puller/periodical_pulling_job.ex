defmodule PrivatCursesPuller.PeriodicalPullingJob do
  require Logger

  alias PrivatCursesPuller.PrivatAPI
  alias PrivatCursesPuller.NotificationsAPI
  alias PrivatCursesPuller.Core.RatesProcessor

  def call do
    Logger.info "PeriodicalPullingJob called..."
    cashless_rates = PrivatAPI.get_cashless_rates
    auth_info = PrivatAPI.auth_commercial_api(client_id, client_secret)
    commercial_rates = PrivatAPI.get_commercial_rates(auth_info.id)
    notification_info = RatesProcessor.call(commercial_rates, cashless_rates)
    NotificationsAPI.notify :slack, notification_info
  end

  defp client_id do
    Application.get_env :privat_curses_puller, :privat_client_id
  end

  defp client_secret do
    Application.get_env :privat_curses_puller, :privat_client_secret
  end
end
