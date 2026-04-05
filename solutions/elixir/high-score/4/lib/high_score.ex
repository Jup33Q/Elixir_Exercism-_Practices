defmodule HighScore do
  @default_score 0
  def new() do
    Map.new()
  end

  def add_player(scores, name) do
    add_player(scores,name,@default_score)
  end

  def add_player(scores, name, score) do
    scores |> Map.put_new(name,score)
  end

  def remove_player(scores, name) do
    {_,rt}=(scores |> Map.pop(name))
    rt
  end

  def reset_score(scores, name) do
    case scores |> Map.has_key?(name) do
      true ->
     scores |> Map.replace(name,@default_score)
     false -> add_player(scores,name)
    end


  end

  def update_score(scores, name, score) do
    case scores |> Map.has_key?(name) do

      true ->
    old_score = scores|>Map.get(name)
    scores |> Map.replace(name,score+old_score)
     false -> scores |> Map.put_new(name,score)

    end
  end

  def get_players(scores) do
    {rt , _} = scores |> Enum.unzip()
    rt
  end
end
