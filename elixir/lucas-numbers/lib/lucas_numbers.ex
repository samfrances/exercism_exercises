defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when not is_integer(count) or count < 1 do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
  def generate(count) do
    lucas_stream()
    |> Stream.take(count)
    |> Enum.to_list()
  end

  def lucas_stream() do
    Stream.unfold(
      [], fn
        [] -> {2, [2]}
        [2] -> {1, [1, 2]}
        [n_1, n_2] ->
          next_num = n_1 + n_2
          {next_num, [next_num, n_1]}
      end
    )
  end
end
