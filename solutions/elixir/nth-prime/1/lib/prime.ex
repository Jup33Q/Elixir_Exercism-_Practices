defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  def regulated_remainder(a, b), do: (rem(a, b) + b) |> rem(b)

  def highest_common_factor(0, 0), do: :inf

  def highest_common_factor(_, 1), do: 1

  def highest_common_factor(1, _), do: 1

  def highest_common_factor(a, 0), do: a

  def highest_common_factor(0, a), do: a

  def highest_common_factor(a, b) do
    # Euclidean + Bezout
    regulated_remainder(a, b)
    |> then(fn x -> highest_common_factor(b, x) end)

    # |> dbg
  end

  def coprime?(a, b) do
    highest_common_factor(a, b) == 1
  end

  # THE ABOVE USE DEFINE_OF_PRIME RULES

  def nth(1), do: 2

  def nth(2), do: 3

  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    nth(count - 1)+1
    |> Stream.iterate(fn x -> x + 1 end)
    |> Stream.take(prime_product(count-1)+1-nth(count - 1))
    |> Stream.filter(fn x -> (factorial_mod(x-1,x)+1)==x end)
    |> Enum.take(1)
    |> List.first()
    |> dbg
  end

  # THE BELOW USE WILLS LEMMA

  def factorial(0), do: 1

  def factorial(n)
      when n > 1 and n |> is_integer do
    n * factorial(n - 1)
  end


    def factorial_mod(n, m) when n >= 0 and m > 0 do
    do_factorial_mod(n, m, 1)
  end

  # 基本情况：n 减到 0 时，返回累积值
  defp do_factorial_mod(0, _m, acc), do: acc

  # 递归步骤：累积乘以 n，立即取模检查是否为 0
  defp do_factorial_mod(n, m, acc) when n > 0 do
    new_acc = rem(acc * n, m)

    # 关键：如果取模结果为 0，立即停止递归
    if new_acc == 0 do
      0
    else
      do_factorial_mod(n - 1, m, new_acc)
    end
  end

  def prime_product(0), do: 1

  def prime_product(count) do

    nth(count) * prime_product(count - 1)
  end
end
