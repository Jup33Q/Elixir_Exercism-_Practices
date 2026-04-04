defmodule Lasagna do
  # Please define the 'expected_minutes_in_oven/0' function

def expected_minutes_in_oven do
  40
end

  # Please define the 'remaining_minutes_in_oven/1' function

  # Please define the 'remaining_minutes_in_oven/1' function
  def remaining_minutes_in_oven(time) when time |> is_number do
    Lasagna.expected_minutes_in_oven |> Kernel.-(time)
  end

  # Please define the 'preparation_time_in_minutes/1' function
  def preparation_time_in_minutes(layers) when layers |> is_integer do
    layers |> Kernel.*(2)

  end

  # Please define the 'total_time_in_minutes/2' function
  def total_time_in_minutes(layers, timeInOven) when layers |> is_integer and timeInOven|> is_number do
   (layers|> preparation_time_in_minutes()) + timeInOven


  end

  # Please define the 'alarm/0' function
  def alarm do
    "Ding!"

  end
end
