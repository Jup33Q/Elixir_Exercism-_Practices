defmodule TopSecret do
  def to_ast(string) do
    string
    |> Code.string_to_quoted!()
    |> strip_block_metadata()
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {op, _, [{:when, _, [func_def | _]} | _]} when op in [:def, :defp] ->
        {ast, [extract_message_part(func_def) | acc]}

      {op, _, [func_def | _]} when op in [:def, :defp] ->
        {ast, [extract_message_part(func_def) | acc]}

      _ ->
        {ast, acc}
    end
  end

  def decode_secret_message(string) do
    {_ast, parts} =
      string
      |> to_ast()
      |> Macro.prewalk([], &decode_secret_message_part/2)

    parts
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp strip_block_metadata({:__block__, _, args}) do
    {:__block__, [], Enum.map(args, &strip_block_metadata/1)}
  end

  defp strip_block_metadata({op, meta, args}) when is_list(args) do
    {op, meta, Enum.map(args, &strip_block_metadata/1)}
  end

  defp strip_block_metadata({key, value}) do
    {key, strip_block_metadata(value)}
  end

  defp strip_block_metadata(list) when is_list(list) do
    Enum.map(list, &strip_block_metadata/1)
  end

  defp strip_block_metadata(other), do: other

  defp extract_message_part({name, _, args}) when is_list(args) do
    name
    |> to_string()
    |> String.slice(0, length(args))
  end

  defp extract_message_part({_name, _, nil}) do
    ""
  end
end
