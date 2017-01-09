use Mix.Config

config :privat_curses_puller,
  notifiers: [:slack],
  target_ccy: System.get_env("PCP_TARGET_CCY")

config :privat_curses_puller, :privat_api,
  client_id: System.get_env("PCP_PRIVAT_CLIENT_ID"),
  client_secret: System.get_env("PCP_PRIVAT_CLIENT_SECRET")

config :privat_curses_puller, :slack_notifier,
  hook_url: System.get_env("PCP_SLACK_NOTIFICATION_HOOK_URL")

