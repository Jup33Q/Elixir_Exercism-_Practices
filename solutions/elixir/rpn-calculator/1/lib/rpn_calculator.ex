defmodule RPNCalculator do
  def calculate!(stack, operation) do
    stack |> then(operation)
  end

  def calculate(stack, operation) do
    try do
      stack
      |> then(operation)
      |> then(&{:ok, &1})
    rescue
      x ->
        :error
    end
  end

  def calculate_verbose(stack, operation) do
    # Please implement the calculate_verbose/2 function
    try do
      stack |> then(operation) |> then(&({:ok,&1}))
    rescue
      x ->
        {:error, x |> Map.get(:message)}
    end
  end
end
