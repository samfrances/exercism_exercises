defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  require Integer

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    input
    |> sequence()
    |> Enum.count()
  end

  defp sequence(n) do
    n
    |> Stream.iterate(&collatz_step/1)
    |> Stream.take_while(& &1 !== 1)
  end

  defp collatz_step(n) when Integer.is_even(n) do
    div(n, 2)
  end
  defp collatz_step(n) do
    (3 * n) + 1
  end
end
