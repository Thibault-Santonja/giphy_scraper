defmodule GiphyScraperTest do
  use ExUnit.Case
  doctest GiphyScraper

  test "search a given query" do
    random_query = Faker.Color.name()

    assert {:ok, result} = GiphyScraper.search(random_query)
    assert result |> Enum.count() <= 15
    assert result |> Enum.each(fn res -> %GiphyScraper.Type.GiphyImage{} = res end) == :ok
  end

  test "search a given query with a limit" do
    random_query = Faker.Color.name()

    assert {:ok, result} = GiphyScraper.Scraper.search(random_query, 1)
    assert result |> Enum.count() == 1
    assert result |> Enum.each(fn res -> %GiphyScraper.Type.GiphyImage{} = res end) == :ok
  end

  test "verify %GiphyImage{} struct" do
    %GiphyScraper.Type.GiphyImage{
      id: "3ogwFGEHrVxusDbDjO",
      url: "https://giphy.com/gifs/spongebob-spongebob-squarepants-episode-15-3ogwFGEHrVxusDbDjO",
      username: "spongebob",
      title: "Episode 15 Hello GIF by SpongeBob SquarePants"
    }
  end
end
