defmodule KitchenCalculator do
  @ml :milliliter
  @cup :cup
  @fluid_ounce :fluid_ounce
  @tsp :teaspoon
  @tbsp :tablespoon

  @type unit :: :milliliter | :cup | :fluid_ounce | :teaspoon | :tablespoon
  @type unit_volume_pair :: {unit, number}

  @spec get_volume(unit_volume_pair) :: number
  def get_volume({_unit, volume}), do: volume

  @spec to_milliliter(unit_volume_pair) :: {:milliliter, number}
  def to_milliliter({unit, volume}) do
    {
      @ml,
      volume * conversion_factor(unit)
    }
  end

  @spec from_milliliter({:milliliter, number}, unit) :: unit_volume_pair()
  def from_milliliter({@ml, volume}, unit) do
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
  defp conversion_factor(unit) do
    case unit do
      @ml          -> 1
      @cup         -> 240
      @fluid_ounce -> 30
      @tsp         -> 5
      @tbsp        -> 15
    end
  end
end
