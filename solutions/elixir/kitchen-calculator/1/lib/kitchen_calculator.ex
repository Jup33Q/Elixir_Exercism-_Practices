defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 function
    {a,b}=volume_pair
    cond do
      a |> is_number() -> a
      b|> is_number() -> b
    end

  end

  def get_unit(volume_pair) do
    {a,b} =volume_pair
    cond do
      a |> is_atom ->a
      b |> is_atom ->b
    end
  end

  def to_milliliter(volume_pair) do
    # Please implement the to_milliliter/1 functions
    a = volume_pair |> get_unit
    b = volume_pair |> get_volume
   b= ( case a do
      :milliliter -> 1
      :cup -> 240
      :fluid_ounce -> 30
      :teaspoon -> 5
      :tablespoon -> 15
      _ -> 0
    end
   ) |> Kernel.*(b)

   {:milliliter,b}

  end

  def from_milliliter(volume_pair, unit) do
    b= ( case unit do
      :milliliter -> 1 / 1
      :cup -> 1/240
      :fluid_ounce -> 1/30
      :teaspoon -> 1/5
      :tablespoon -> 1/15
      _ -> 0
    end
   ) |> Kernel.*(volume_pair |> get_volume)
   {unit,b}

  end


  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter |> from_milliliter(unit)
    # Please implement the convert/2 function
  end
end
