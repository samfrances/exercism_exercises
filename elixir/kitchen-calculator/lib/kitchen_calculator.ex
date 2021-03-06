defmodule KitchenCalculator do

  @type unit :: :milliliter | :cup | :fluid_ounce | :teaspoon | :tablespoon
  @type unit_volume_pair :: {unit, number}

  @spec get_volume(unit_volume_pair) :: number
  def get_volume({_unit, volume}), do: volume

  @spec to_milliliter(unit_volume_pair) :: {:milliliter, number}
  def to_milliliter({unit, volume}) do
    {
      :milliliter,
      volume * conversion_factor(unit)
    }
  end

  @spec from_milliliter({:milliliter, number}, unit) :: unit_volume_pair()
  def from_milliliter({:milliliter, volume}, unit) do
    {
      unit,
      volume / conversion_factor(unit)
    }
  end

  @spec convert(unit_volume_pair, unit) :: unit_volume_pair()
  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end

  @spec conversion_factor(unit) :: integer()
  defp conversion_factor(:milliliter), do: 1
  defp conversion_factor(:cup), do: 240
  defp conversion_factor(:fluid_ounce), do: 30
  defp conversion_factor(:teaspoon), do: 5
  defp conversion_factor(:tablespoon), do: 15
end
