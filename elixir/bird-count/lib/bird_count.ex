defmodule BirdCount do
  @type birdcounts :: list(non_neg_integer)

  @spec today(birdcounts) :: non_neg_integer
  def today([]), do: nil

  def today([this_day | _] = counts)
      when length(counts) > 0,
      do: this_day

  @spec increment_day_count(birdcounts) :: birdcounts
  def increment_day_count([]), do: [1]

  def increment_day_count([today | rest] = counts)
      when length(counts) >= 1,
      do: [today + 1 | rest]

  @spec has_day_without_birds?(birdcounts) :: boolean
  def has_day_without_birds?(list) do
    list
    |> Enum.any?(&(&1 == 0))
  end

  @spec total(birdcounts) :: non_neg_integer
  def total(list) do
    Enum.sum(list)
  end

  @spec busy_days(birdcounts) :: non_neg_integer
  def busy_days(list) do
    list
    |> Enum.filter(&busy?/1)
    |> Enum.count()
  end

  defp busy?(day), do: day >= 5
end
