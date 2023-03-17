defmodule GiphyScraper.Scraper do
  @moduledoc """
  Documentation for `GiphyScraper`.
  """

  alias GiphyScraper.Type.GiphyImage

  @giphy_search_endpoint "https://api.giphy.com/v1/gifs/search"
  @giphy_api_key Application.get_env(:giphy_scraper, :giphy_api_key)

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
  def search(query) when is_binary(query) do
    headers = [{"Accept", "application/json"}]
    body = %{
      q: query,
      api_key: @giphy_api_key,
      lang: "en",
      limit: 15
    } |> Jason.encode_to_iodata!()

    Finch.start_link(name: MyFinch)
    Finch.build(:get, @giphy_search_endpoint, headers, body) |> Finch.request(MyFinch)
  end

  @spec search(any) :: any() #{Atom, String.t}
  def search(_) do
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
