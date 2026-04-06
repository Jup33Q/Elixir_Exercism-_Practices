defmodule Prime do
  @doc """
  Generates the nth prime.

  from kensuke
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: (raise ArgumentError, message: "invalid argument zero")
  def nth(count) do
    count |> nth_prime_list |> List.first
  end

  def append_prime_list([]), do: [2]

  def append_prime_list(last_list) do
    [prime_after_list(last_list) |last_list]
  end

  def nth_prime_list(1) , do: [2]

  def nth_prime_list (n) do
    nth_prime_list(n-1)|>append_prime_list()

  end

  def prime_after_list(list_n=[p_n|_]) do
   p_n |> Stream.iterate(&(&1+1))
   |>Stream.filter(&(&1 |> prime?(list_n)))
   |> Enum.take(1) |> List.first
  end

  def prime?(q,prime_list_n) do
    prime_list_n |> Stream.map(&(rem(q,&1)))
    |> Enum.reduce_while(
     1,
    fn x, acc ->
      (case x do
        0 -> {:halt, 0}

        _ -> {:cont,acc*x}

      end)
    end
    )
    |> Kernel.==(0)
    |> Kernel.not
  end

  def prime?(q), do: prime?(q ,Range.new(2,q-1) )


end
