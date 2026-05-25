defmodule Dot do
  alias Graph

  @spec graph(do: {:__block__, keyword(), list()}) :: Graph.t()
  defmacro graph(do: _do_block = {:__block__, _, detail}) do
    detail
    |> Enum.map(&parse(&1))
    |> bind_lines(Graph.new())
    |> Macro.escape()
  end

  @spec graph(do: term()) :: Graph.t()
  defmacro graph(do: detail) do
    detail
    |> parse()
    |> bind_single_line(Graph.new())
    |> Macro.escape()
  end

  @spec graph(any()) :: Graph.t()
  defmacro graph(_ast) do
    Graph.new() |> Macro.escape()
  end

  # graph(foo: bar)
  defp parse({:graph, _, [args]}) when is_list(args) do
    if Keyword.keyword?(args) do
      {:graph, args}
    else
      raise ArgumentError
    end
  end

  # graph()
  defp parse({:graph, _, []}) do
    raise ArgumentError
  end

  # graph (standalone)
  defp parse({:graph, _, nil}) do
    raise ArgumentError
  end

  # a -- b
  defp parse({:--, _, [{node1, _, nil}, {node2, _, nil}]})
       when is_atom(node1) and is_atom(node2) and node1 != :graph and node2 != :graph do
    {:edge, {node1, node2}, []}
  end

  # a -- b(foo: baz)
  defp parse({:--, _, [{node1, _, nil}, {node2, _, [attr]}]})
       when is_atom(node1) and is_atom(node2) and node1 != :graph and node2 != :graph and
              is_list(attr) do
    if Keyword.keyword?(attr) do
      {:edge, {node1, node2}, attr}
    else
      raise ArgumentError
    end
  end

  # a -- b([])
  defp parse({:--, _, [{node1, _, nil}, {node2, _, [attr]}]})
       when is_atom(node1) and is_atom(node2) and node1 != :graph and node2 != :graph and
              attr == [] do
    {:edge, {node1, node2}, []}
  end

  # a
  defp parse({node, _, nil})
       when is_atom(node) and node != :graph do
    {:node, node, []}
  end

  # a(foo: baz)
  defp parse({node, _, [attr]})
       when is_atom(node) and node != :graph and is_list(attr) do
    if Keyword.keyword?(attr) do
      {:node, node, attr}
    else
      raise ArgumentError
    end
  end

  # a([])
  defp parse({node, _, [attr]})
       when is_atom(node) and node != :graph and attr == [] do
    {:node, node, []}
  end

  # unknown statement
  defp parse(_detail) do
    raise ArgumentError
  end

  @spec bind_lines(list(), Graph.t()) :: Graph.t()
  def bind_lines(details, graph) do
    bind_lines_rc(graph, details)
  end

  @spec bind_lines_rc(Graph.t(), []) :: Graph.t()
  def bind_lines_rc(graph, []) do
    graph
  end

  @spec bind_lines_rc(Graph.t(), list()) :: Graph.t()
  def bind_lines_rc(graph, _details = [hd | remain]) do
    bind_lines_rc(bind_single_line(hd, graph), remain)
  end

  @spec bind_single_line(term(), Graph.t()) :: Graph.t()
  defp bind_single_line({:node, node, []}, graph) do
    graph |> Graph.add_node(node)
  end

  defp bind_single_line({:node, node, attr}, graph) do
    graph |> Graph.add_node(node, attr)
  end

  defp bind_single_line({:edge, {node1, node2}, attr}, graph) do
    graph |> Graph.add_edge(node1, node2, attr)
  end

  defp bind_single_line({:graph, args}, graph) do
    graph |> Graph.put_attrs(args)
  end
end
