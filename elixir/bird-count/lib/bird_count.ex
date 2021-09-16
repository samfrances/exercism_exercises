defmodule BirdCount do
  @type birdcounts :: list(non_neg_integer)

  @spec today(birdcounts) :: non_neg_integer
  def today([]), do: nil

  def today([this_day | _]), do: this_day

  @spec increment_day_count(birdcounts) :: birdcounts
  def increment_day_count([]), do: [1]
  def increment_day_count([today | rest]), do: [today + 1 | rest]

  @spec has_day_without_birds?(birdcounts) :: boolean
  def has_day_without_birds?(list) do
    list
    |> MyEnum.any?(&(&1 == 0))
  end

  @spec total(birdcounts) :: non_neg_integer
  def total(list) do
    MyEnum.sum(list)
  end

  @spec busy_days(birdcounts) :: non_neg_integer
  def busy_days(list) do
    list
    |> MyEnum.filter(&busy?/1)
    |> MyEnum.count()
  end

  defp busy?(day), do: day >= 5
end

defmodule MyEnum do
  @doc """
  Because this is ment to be an exercise in recursion,
  re-implement Enum functions using recursion
  """

  def any?(list, func) do
    any?(list, func, false)
  end

  defp any?([], _func, found?), do: found?
  defp any?(_list, _func, found? = true), do: found?

  defp any?([first | rest], func, _found?) do
    any?(rest, func, func.(first))
  end

  @spec sum([number]) :: number
  def sum(list) do
    sum(list, 0)
  end

  defp sum([], count), do: count

  defp sum([first | rest], count) do
    sum(rest, first + count)
  end

  @spec count(list) :: non_neg_integer
  def count(list) do
    count(list, 0)
  end

  defp count([], counter), do: counter

  defp count([_first | rest], counter) do
    count(rest, counter + 1)
  end

  def filter(list, predicate) do
    filter(list, predicate, [])
  end

  defp filter([], _predicate, result) do
    reverse(result)
  end

  defp filter([first | rest], predicate, result) do
    new_result =
      if predicate.(first) do
        [first | result]
      else
        result
      end

    filter(rest, predicate, new_result)
  end

  defp reverse(list) do
    reverse(list, [])
  end

  defp reverse([], result), do: result

  defp reverse([first | rest], result) do
    reverse(rest, [first | result])
  end
end
