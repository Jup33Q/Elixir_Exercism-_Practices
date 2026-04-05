defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    new_collection = [card] |> MapSet.new() |> MapSet.union(collection)
    {collection |> MapSet.member?(card), new_collection}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    new_collection = collection |> MapSet.delete(your_card) |> MapSet.put(their_card)

    do_trade =
      not (collection |> MapSet.member?(their_card)) and collection |> MapSet.member?(your_card)

    {do_trade, new_collection}
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards |> MapSet.new() |> Enum.to_list()|> Enum.sort
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    your_collection |> MapSet.difference(their_collection) |> Enum.count()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards(collections) do

      collections |> boring_cards_as_set |> Enum.to_list() |> Enum.sort

  end

def boring_cards_as_set([]),do: MapSet.new()

def boring_cards_as_set([only_collection]),do: only_collection

  def boring_cards_as_set(collections) do

      [a | b] = collections
    a |> MapSet.intersection(boring_cards_as_set(b)) |> dbg

  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards_set([]), do: MapSet.new()
  def total_cards_set(collections) do
    [first|remain]=collections
    first |> MapSet.union(remain |> total_cards_set)
  end
  def total_cards(collections) do
    collections|>total_cards_set()|> MapSet.size
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    shiny_cards =collection |> Enum.filter(&(&1 |> String.starts_with?("Shiny "))) |> Enum.sort
    normal_cards =collection |> Enum.reject(&(&1 |> String.starts_with?("Shiny "))) |> Enum.sort
    {shiny_cards,normal_cards}
  end
end
