defmodule LanguageList do

  def new() do
    []
  end

  def add(list, language) do
    [language|list]
  end

  def remove(list) do
    [_|tail] = list
    tail

  end

  def first(list) do
    list |> List.first()
  end

  def count([]), do: 0

  def count(list) do
    [_|tail] =list
    count(tail)
  end

  def functional_list?(list) do
    "Elixir" in list

  end
end
