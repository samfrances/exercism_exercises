defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    reg_num =
      Random.exclusive(1000, 10000)
      |> trunc()
    "NCC-#{reg_num}"
  end

  def random_stardate() do
    Random.exclusive(41000, 42000)
  end

  def format_stardate(stardate) do
    :erlang.float_to_binary(stardate, decimals: 1)
  end
end

defmodule Random do
  def exclusive(lower, upper) do
    (:rand.uniform() * (upper - lower)) + lower
  end
end
