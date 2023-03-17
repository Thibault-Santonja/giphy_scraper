defmodule GiphyScraper do
  @moduledoc """
  Entry point for `GiphyScraper`.
  """
  use Application

  defdelegate search(query), to: GiphyScraper.Scraper

  def start(_type, _args) do
    GiphyScraper.Supervisor.start_link(name: MyFinch)
  end
end
