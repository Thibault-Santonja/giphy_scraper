defmodule GiphyScraper do
  @moduledoc """
  Documentation for `GiphyScraper`.
  """
  defdelegate search(query), to: GiphyScraper.Scraper
end
