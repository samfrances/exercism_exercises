defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first, second | _rest] = colors) when length(colors) >= 2 do
    ResistorColor.code(first) * 10 + ResistorColor.code(second)
  end
end


defmodule ResistorColor do

  @resistor_values [
    :black,
    :brown,
    :red,
    :orange,
    :yellow,
    :green,
    :blue,
    :violet,
    :grey,
    :white
  ]

  @doc """
  Return the value of a color band
  """
  @spec code(
          :black
          | :blue
          | :brown
          | :green
          | :grey
          | :orange
          | :red
          | :violet
          | :white
          | :yellow
        ) :: non_neg_integer
  def code(code) when code in @resistor_values do
    Enum.find_index(@resistor_values, fn x -> x == code end)
  end

end
