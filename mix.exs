defmodule PrivatCursesPuller.Mixfile do
  use Mix.Project

  def project do
    [app: :privat_curses_puller,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :quantum, :httpotion, :jsx, :exjsx, :inflex],
     mod: {PrivatCursesPuller, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:quantum, ">= 1.8.1"},
      {:httpotion, "~> 3.0.2"},
      {:exjsx, "3.2.1"},
      {:mock, "~> 0.2.0", only: :test},
      {:inflex, "~> 1.7.0"},
      {:exrm, "~> 1.0"}
    ]
  end
end
