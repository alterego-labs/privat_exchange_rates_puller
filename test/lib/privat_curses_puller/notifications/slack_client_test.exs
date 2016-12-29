defmodule PrivatCursesPuller.Notifications.SlackClientTest do
  use ExUnit.Case, async: false

  import Mock

  alias PrivatCursesPuller.Notifications.SlackClient
  alias PrivatCursesPuller.Core.RatesNotificationInfo

  test "sends info successfully" do
    with_mock HTTPotion, [post: fn(_url, _opts) -> :ok end] do
      notification_info = %RatesNotificationInfo{}
      :ok = SlackClient.call(notification_info)
    end
  end
end
