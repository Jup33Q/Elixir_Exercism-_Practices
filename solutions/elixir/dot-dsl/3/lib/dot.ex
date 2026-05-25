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
    Graph.new()|> Macro.escape()
  end
# graph[foo: baz]
  defp parse({:graph, _, [args]}) when args |> is_list do
    {:graph, args}
  end
  # a -- b
  defp parse({:--, _, [{node1, _, nil}, {node2, _, nil}]}) do
    {:edge, {node1, node2}, []}
  end

  # a -- b(foo: baz)
  defp parse({:--, _, [{node1, _, nil}, {node2, _, [attr]}]})
       when attr |> is_list do
    {:edge, {node1, node2}, attr}
  end

  # a
  defp parse({node, _, nil} = _detail) do
    {:node, node, []}
  end

  # a(foo: baz)
  defp parse({node, _, [attr]}) when attr |> is_list do
    {:node, node, attr}
  end

  # a([])
  defp parse({node, _, []}) do
    {:node, node, []}
  end

  # a[foo: baz]
  defp parse(
         {{:., _, [Access, :get]}, _,
          [{node, _, nil}, attr]}
       )
       when attr |> is_list() do
    {:node, node, attr}
  end

  # a -- b[foo: baz]
  defp parse(
         {:--, _,
          [
            {node1, _, nil},
            {{:., _, [Access, :get]}, _,
             [{node2, _, nil}, attr]}
          ]}
       )
       when attr |> is_list() do
    {:edge, {node1, node2}, attr}
  end

  defp parse(
         {:--, _,
          [
            {node1, _, nil},
            {{:., _, [Access, :get]}, _,
             [{node2, _, nil}, attr]}
          ]}
       )
       when attr |> is_list() do
    {:edge, {node1, node2}, attr}
  end




  # unknown statement
  defp parse(detail) do
    detail |> IO.inspect()
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
    bind_lines_rc(bind_single_line(hd, graph),remain)
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

  defp bind_single_line({:graph, args},graph) do
    graph |> Graph.put_attrs(args)
  end


  defp bind_single_line(detail, graph) do
    detail |> IO.inspect()
    graph
  end
end
