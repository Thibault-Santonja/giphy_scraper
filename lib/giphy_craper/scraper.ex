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

      iex> GiphyScraper.search(query, limit)
      [
        %GiphyScraper.GiphyImage{
          id: "some_id",
          url: "url_to_gif",
          username: "username of creator",
          title: "SomeGif"
        }
      ]

  """
  # {Atom, list(%GiphyImage{})}
  @spec search(String.t()) :: any()
  # {Atom, list(%GiphyImage{})}
  @spec search(String.t(), integer()) :: any()
  def search(query, limit \\ 15)

  def search(query, limit) when is_binary(query) do
    :get
    |> Finch.build(get_query(query, limit))
    |> Finch.request(GiphyScrapper.Finch)
    |> decode_response()
  end

  # {Atom, String.t}
  @spec search(any) :: any()
  def search(_, _) do
    {:error, "Bad argument"}
  end

  defp get_query(query, limit),
    do: "#{@giphy_search_endpoint}?api_key=#{@giphy_api_key}&limit=#{limit}&q=#{query}"

  defp decode_response({:ok, %Finch.Response{status: status, body: body}}) when status < 400 do
    case Jason.decode(body) do
      {:ok, %{"data" => giphies}} ->
        {
          :ok,
          Enum.map(giphies, fn giphy ->
            %GiphyImage{
              id: giphy |> Map.get("id"),
              url: giphy |> Map.get("url"),
              username: giphy |> Map.get("username"),
              title: giphy |> Map.get("title")
            }
          end)
        }

      error ->
        error
    end
  end

  defp decode_response({:ok, %Finch.Response{} = error}), do: {:error, error}
  defp decode_response(error), do: error

  def image do
  end
end
