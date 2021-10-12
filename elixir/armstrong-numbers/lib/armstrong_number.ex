defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    the_digits = digits(number, [])
    digit_count = length(the_digits)

    the_digits
    |> Enum.map(& Integer.pow(&1, digit_count))
    |> Enum.sum()
    |> Kernel.===(number)
  end

  defp digits(0, []), do: [0]
  defp digits(0, result), do: result
  defp digits(number, result) do
    base = 10
    quotient = div(number, base)
    remainder = rem(number, base)
    digits(quotient, [remainder | result])
  end
end
