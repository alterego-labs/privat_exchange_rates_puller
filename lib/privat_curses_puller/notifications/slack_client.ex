defmodule PrivatCursesPuller.Notifications.SlackClient do
  alias PrivatCursesPuller.Core.RatesNotificationInfo

  @spec call(RatesNotificationInfo.t) :: :ok
  def call(%RatesNotificationInfo{} = rates_notification_info) do
    headers = ["Content-Type": "application/json"]
    {:ok, post_body_json} = rates_notification_info |> build_map_data |> JSX.encode
    HTTPotion.post fetch_hook_url, [body: post_body_json, headers: headers]
    :ok
  end

  defp build_map_data(rates_notification_info) do
    %{
      text: "*Fresh information about PrivatBank exchange rates!*",
      attachments: [
        %{
          fallback: "",
          pretext: "",
          color: info_color(rates_notification_info.ratio),
          fields: [
            %{
              title: "Target currency",
              value: rates_notification_info.ccy,
              short: false
            },
            %{
              title: "Sale",
              value: rates_notification_info.sale,
              short: true
            },
            %{
              title: "Buy",
              value: rates_notification_info.buy,
              short: true
            },
            %{
              title: "Ratio",
              value: rates_notification_info.ratio,
              short: false
            }
          ]
        }
      ]
    }
  end

  defp fetch_hook_url do
    :privat_curses_puller
    |> Application.get_env(:slack_notifier)
    |> Keyword.get(:hook_url)
  end

  defp info_color(ratio) when ratio <= 1.1, do: "#80FF00"
  defp info_color(ratio) when ratio <= 2.0, do: "#FFFF00"
  defp info_color(ratio) when ratio <= 3.0, do: "#F37878"
  defp info_color(_ratio), do: "#FF0000"
end
