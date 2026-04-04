defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name = name |> String.trim
    <<f, _::binary>> = name
    <<f>>
  end

  def initial(name) do
    (name |> first_letter |> String.upcase()) <> "."
  end

  def initials(full_name) do
    [a,b] = String.split(full_name)
    (a |> initial)<>" "<>(b|> initial)
  end

  def pair(full_name1, full_name2) do

    """
    ❤-------------------❤
    |  #{full_name1 |> initials}  +  #{full_name2 |> initials}  |
    ❤-------------------❤
    """

  end
end
