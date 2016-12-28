defmodule PrivatCursesPuller.NotificationsAPI do
  @moduledoc """
  Notification subsystem API layer
  """

  alias PrivatCursesPuller.Notifications.SlackClient
  alias PrivatCursesPuller.Core.RatesNotificationInfo

  @type client_key :: :slack

  @doc """
  Sends notification to the Slack
  """
  @spec notify(client_key, RatesNotificationInfo.t) :: none
  def notify(:slack, curses_notification_info) do
    SlackClient.call(curses_notification_info)
  end
end
