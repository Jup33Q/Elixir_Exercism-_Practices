defmodule BirdCount do

  def today([]) do
    nil
  end

  def today(list) do
    [rt|_]=list
    rt
  end

  def increment_day_count([]) do
    [1,]
  end
  def increment_day_count(list) do
    [a | remain] =list
    [a+1 | remain]
    # Please implement the increment_day_count/1 function
  end

  def has_day_without_birds?(list) do
    list |> MapSet.new |> MapSet.member?(0)
  end

   def has_day_without_birds?([]) do
    0
  end

  def total([]), do: 0

  def total(list) do
    [a|remain] = list
    a + total(remain)
  end

  def busy_days([]), do: 0

  def busy_days(list) do
    [a|remain] =list
    case a>=5 do
      true -> busy_days(remain)+1
      false ->busy_days(remain)
    end
  end
end
