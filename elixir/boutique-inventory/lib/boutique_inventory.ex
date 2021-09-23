defmodule BoutiqueInventory do

  @type item :: %{
    name: String.t,
    price: non_neg_integer|nil,
    quantity_by_size: %{
      s: non_neg_integer,
      m: non_neg_integer,
      l: non_neg_integer,
      xl: non_neg_integer
    }
  }

  @type inventory :: [item]

  @spec sort_by_price(inventory) :: inventory
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort(fn x, y -> x.price <= y.price end)
  end

  @spec with_missing_price(inventory) :: inventory
  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(fn x -> is_nil(x.price) end)
  end

  @spec increase_quantity(item, non_neg_integer) :: item
  def increase_quantity(item, count) do
    quantities =
      item.quantity_by_size
      |> Enum.map(fn {size, n} -> {size, n + count} end)
      |> Enum.into(%{})
    %{ item | quantity_by_size: quantities }
  end

  @spec total_quantity(item) :: non_neg_integer
  def total_quantity(item) do
    item.quantity_by_size
    |> Map.values()
    |> Enum.sum()
  end
end
