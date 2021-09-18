defmodule ResistorColor do
  @doc """
  Return the value of a color band
  """

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

  def code(code) when code in @resistor_values do
    Enum.find_index(@resistor_values, fn x -> x == code end)
  end

end
