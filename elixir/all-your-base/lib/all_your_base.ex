defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    with :ok <- validate_output_base(output_base),
         :ok <- validate_input_base(input_base),
         :ok <- validate_digits(digits, input_base) do
      new_base =
        digits
        |> to_base_10_int(input_base)
        |> int_to_base_x(output_base, [])

      {:ok, new_base}
    end
  end

  defp validate_output_base(n) when n >= 2, do: :ok
  defp validate_output_base(_n), do: {:error, "output base must be >= 2"}

  defp validate_input_base(n) when n >= 2, do: :ok
  defp validate_input_base(_n), do: {:error, "input base must be >= 2"}

  defp validate_digits(digits, input_base) do
    if Enum.all?(digits, &valid_digit(&1, input_base)) do
      :ok
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp valid_digit(digit, input_base) do
    digit >= 0 and digit < input_base
  end

  defp to_base_10_int(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {digit, power} -> digit * Integer.pow(input_base, power) end)
    |> Enum.sum()
  end

  defp int_to_base_x(0, _output_base, []), do: [0]
  defp int_to_base_x(0, _output_base, result), do: result

  defp int_to_base_x(number, output_base, result) do
    quotient = div(number, output_base)
    remainder = rem(number, output_base)
    int_to_base_x(quotient, output_base, [remainder | result])
  end
end
