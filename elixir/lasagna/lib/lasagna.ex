defmodule Lasagna do

  @spec expected_minutes_in_oven :: 40
  def expected_minutes_in_oven(), do: 40

  @spec remaining_minutes_in_oven(non_neg_integer()) :: integer()
  def remaining_minutes_in_oven(mins_so_far) do
    expected_minutes_in_oven() - mins_so_far
  end

  @spec preparation_time_in_minutes(non_neg_integer()) :: non_neg_integer()
  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  @spec total_time_in_minutes(non_neg_integer(), non_neg_integer()) :: non_neg_integer()
  def total_time_in_minutes(layers, mins_so_far) do
    preparation_time_in_minutes(layers) + mins_so_far
  end

  def alarm() do
    "Ding!"
  end
end
