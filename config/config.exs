use Mix.Config

config :logger,
  backends: [:console],
  compile_time_purge_level: :info

config :quantum, cron: [
  "* * * * *": {PrivatCursesPuller.PeriodicalPullingJob, :call},
]

import_config "#{Mix.env}.exs"
