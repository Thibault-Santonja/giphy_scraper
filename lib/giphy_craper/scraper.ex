defmodule GiphyScraper.Scraper do
  @moduledoc """
  Documentation for `GiphyScraper`.
  """

  alias GiphyScraper.Type.GiphyImage
  require Logger

  @giphy_search_endpoint "https://api.giphy.com/v1/gifs/search"
  @giphy_api_key Application.compile_env(:giphy_scraper, :giphy_api_key)

  @doc """
  Search a gif.

  ## Examples

      iex> GiphyScraper.search(query)
      [
        %GiphyScraper.GiphyImage{
          id: "some_id",
          url: "url_to_gif",
          username: "username of creator",
          title: "SomeGif"
        },

        %GiphyScraper.GiphyImage{
          id: "some_other_id",
          url: "url_to_gif_2",
          username: "username of creator",
          title: "MyGif"
        }
      ]

  """
  @spec search(String.t) :: any() #{Atom, list(%GiphyImage{})}
  @spec search(String.t, integer()) :: any() #{Atom, list(%GiphyImage{})}
  def search(query, limit \\ 15)

  def search(query, limit) when is_binary(query) do
    query = "#{@giphy_search_endpoint}?api_key=#{@giphy_api_key}&limit=#{limit}&q#{query}"

    Logger.info("Query : #{query}")

    #Finch.start_link(name: MyFinch)
    Finch.build(:get, query) |> Finch.request(GiphyScrapper.Finch)
  end

  @spec search(any) :: any() #{Atom, String.t}
  def search(_, _) do
    {:error, "Bad argument"}
  end

  def image do
    %GiphyImage{
      id: "String.t",
      url: "String.t",
      username: "String.t",
      title: "String.t"
    }
  end
end
