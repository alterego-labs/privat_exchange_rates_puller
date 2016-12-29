use Mix.Config

config :privat_curses_puller,
  notifiers: [:slack],
  target_ccy: "USD"

config :privat_curses_puller, :privat_api,
  client_id: "client_id",
  client_secret: "client_secret"

config :privat_curses_puller, :slack_notifier,
  hook_url: "https://some.hook.url.slack.com"

