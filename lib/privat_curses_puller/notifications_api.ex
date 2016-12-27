defmodule PrivatCursesPuller.NotificationsAPI do
  @moduledoc """
  Notification subsystem API layer
  """

  alias PrivatCursesPuller.Notifications.SlackClient
  alias PrivatCursesPuller.Core.CursesNotificationInfo

  @type client_key :: :slack

  @doc """
  Sends notification to the Slack
  """
  @spec notify(client_key, CursesNotificationInfo.t) :: none
  def notify(:slack, curses_notification_info) do
    SlackClient.call(curses_notification_info)
  end
end
