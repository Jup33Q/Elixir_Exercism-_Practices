defmodule LanguageList do

  def new() do
    []
  end

  def add(list, language) do
    [language|list]
  end

  def remove(list) do
    x = list|>List.first()
    [x|remain]=list
    remain

  end

  def first(list) do
    list |> List.first()
  end


  def count(list) do
    list |> Enum.count

  end

  def functional_list?(list) do
    "Elixir" in list

  end
end
