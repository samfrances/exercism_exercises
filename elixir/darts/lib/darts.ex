defmodule Darts do
  @type position :: {number, number}
  @type circle :: :center | :middle | :outer

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score(pos) do
    pos |> lands_within() |> score_circle()
  end

  defp score_circle(:center),  do: 10
  defp score_circle(:middle), do: 5
  defp score_circle(:outer),  do: 1
  defp score_circle(_),       do: 0

  @spec lands_within(pos :: position) :: circle | nil
  defp lands_within({x, y}) do
    cond do
      distance_from_center({x, y}) <= 1  -> :center
      distance_from_center({x, y}) <= 5  -> :middle
      distance_from_center({x, y}) <= 10 -> :outer
      true                               -> nil
    end
  end

  @spec distance_from_center(position) :: float
  defp distance_from_center({x, y}) do
    Geometry.pythagoras(x, y) |> abs()
  end

end

defmodule Geometry do

  @spec pythagoras(number, number) :: float
  def pythagoras(a, b) do
    :math.pow(a, 2) + :math.pow(b, 2)
    |> :math.sqrt()
  end

end
