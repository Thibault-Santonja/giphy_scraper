defmodule GiphyScraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :giphy_scraper,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GiphyScraper, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:finch, "~> 0.15.0"},
      {:jason, "~> 1.4.0"},
      {:faker, "~> 0.17.0"}  # only for tests
    ]
  end
end
