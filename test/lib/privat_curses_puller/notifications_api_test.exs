defmodule PrivatCursesPuller.NotificationsAPITest do
  use ExUnit.Case, async: true

  import Mock

  alias PrivatCursesPuller.Core.RatesNotificationInfo
  alias PrivatCursesPuller.NotificationsAPI
  alias PrivatCursesPuller.Notifications.SlackClient

  @tag :wip
  test "notify calls slack client" do
    with_mock SlackClient, [call: fn(%RatesNotificationInfo{}) -> :ok end] do
      NotificationsAPI.notify(:slack, %RatesNotificationInfo{})
    end
  end
end
