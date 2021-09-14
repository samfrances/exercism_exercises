defmodule Darts do
  @type position :: {number, number}
  @type circle :: :center | :middle | :outer

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score(pos) do
    cond do
      lands_within(:center, pos) -> 10
      lands_within(:middle, pos) -> 5
      lands_within(:outer, pos)  -> 1
      true                       -> 0
    end
  end

  @spec lands_within(circle :: circle, pos :: position) :: boolean
  defp lands_within(:outer, {x, y}) do
    distance_from_center({x, y}) <= 10
  end
  defp lands_within(:middle, {x, y}) do
    distance_from_center({x, y}) <= 5
  end
  defp lands_within(:center, {x, y}) do
    distance_from_center({x, y}) <= 1
  end

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
