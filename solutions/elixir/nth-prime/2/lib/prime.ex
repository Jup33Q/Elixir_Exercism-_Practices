defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: (raise ArgumentError, message: "invalid argument zero")
  def nth(count) do
    Stream.iterate(2, &(&1 + 1)) |> Stream.filter(&prime?/1) |> Enum.take(count) |> List.last()
  end

  defp prime?(x), do: 2..x |> Enum.filter(fn a -> rem(x, a) == 0 end) |> length() == 1
end
