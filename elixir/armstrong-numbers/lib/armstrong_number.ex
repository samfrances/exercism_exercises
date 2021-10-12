defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    exponent = length(digits)

    digits
    |> Enum.map(& Integer.pow(&1, exponent))
    |> Enum.sum()
    |> Kernel.===(number)
  end

end
