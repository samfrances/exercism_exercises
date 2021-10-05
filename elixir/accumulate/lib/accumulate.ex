defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    accumulate(list, fun, [])
  end

  defp accumulate([], _fun, result) do
    reverse(result)
  end

  defp accumulate([first|rest], fun, result) do
    accumulate(rest, fun, [fun.(first)|result])
  end

  defp reverse(list) do
    reverse(list, [])
  end

  defp reverse([], result), do: result
  defp reverse([first|rest], result) do
    reverse(rest, [first|result])
  end
end
