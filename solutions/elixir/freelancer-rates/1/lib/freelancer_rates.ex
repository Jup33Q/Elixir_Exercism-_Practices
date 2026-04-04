defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    # Please implement the daily_rate/1 function
    hourly_rate * 8.0

  end

  def apply_discount(before_discount, discount) do
    # Please implement the apply_discount/2 function
    before_discount * (100.0 -discount)/100.0
  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    (hourly_rate |> daily_rate |> apply_discount(discount))*22 |> ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    (budget / (hourly_rate |> daily_rate |>apply_discount(discount))) *10 |>round  /10
  end
end
