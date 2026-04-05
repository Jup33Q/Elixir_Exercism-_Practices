defmodule LanguageList do

  def new() do
    []
  end

  def add(list, language) do
    [language|list]
  end

  def remove(list) do
    list |> List.last()

  end

  def first(list) do
    list |> List.first()
  end

  def count([]), do: 0



  def count(list) do
    list

  end

  def functional_list?(list) do
    "Elixir" in list

  end
end
