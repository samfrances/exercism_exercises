defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, _input_base, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end
  def convert(_digits, input_base, _output_base) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end
  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, invalid_digit(input_base)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {:ok, convert_safe(digits, input_base, output_base)}
    end
  end

  defp invalid_digit(input_base) do
    fn digit -> digit < 0 or digit >= input_base end
  end

  defp convert_safe(digits, input_base, output_base) do
    digits
    |> to_base_10_int(input_base)
    |> to_base_x_int(output_base, [])
  end

  defp to_base_10_int(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Stream.zip(Stream.iterate(0, & &1 + 1))
    |> Stream.map(fn {digit, power} -> digit * Integer.pow(input_base, power) end)
    |> Enum.sum()
  end

  def to_base_x_int(0, _output_base, []), do: [0]
  def to_base_x_int(0, _output_base, result), do: result
  def to_base_x_int(number, output_base, result) do
    quotient = div(number, output_base)
    remainder = rem(number, output_base)
    to_base_x_int(quotient, output_base, [remainder | result])
  end

end
