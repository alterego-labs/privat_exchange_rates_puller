use Mix.Config

config :privat_curses_puller,
  privat_client_id: System.get_env("PRIVAT_CLIENT_ID"),
  privat_client_secret: System.get_env("PRIVAT_CLIENT_SECRET"),
  slack_notification_hook_url: System.get_env("SLACK_NOTIFICATION_HOOK_URL")

config :logger,
  backends: [:console],
  compile_time_purge_level: :info

config :quantum, cron: [
  "* * * * *":      {PrivatCursesPuller.PeriodicalPullingJob, :call},
]
