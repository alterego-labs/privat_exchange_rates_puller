use Mix.Config

config :logger,
  backends: [:console],
  compile_time_purge_level: :info

config :quantum, cron: [
  # Each Mon, Tue, Wed, Thur, Fri at 10 till 13 o'clock
  "* 10,11,12,13 * * 1,2,3,4,5": {PrivatCursesPuller.PeriodicalPullingJob, :call},
]

import_config "#{Mix.env}.exs"
