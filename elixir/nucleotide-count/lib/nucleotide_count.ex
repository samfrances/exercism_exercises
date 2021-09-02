defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    count_tail(strand, nucleotide, 0)
  end

  @spec count_tail(charlist(), char(), non_neg_integer()) :: non_neg_integer()
  defp count_tail([], nucleotide, count), do: count
  defp count_tail([nucleotide|rest], nucleotide, count) do
    count_tail(rest, nucleotide, count + 1)
  end
  defp count_tail([_|rest], nucleotide, count) do
    count_tail(rest, nucleotide, count)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    histogram_tail(
      strand,
      Map.new(@nucleotides, fn nuc -> {nuc, 0} end)
    )
  end

  @spec histogram_tail(charlist(), map()) :: map()
  defp histogram_tail([], counters), do: counters
  defp histogram_tail([nucleotide|rest], counters) do
    updated_counters = Map.update(
      counters,
      nucleotide,
      1,
      & &1 + 1
    )
    histogram_tail(rest, updated_counters)
  end

end
