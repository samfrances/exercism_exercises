defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &char_to_rna/1)
  end

  defp char_to_rna(?G), do: ?C
  defp char_to_rna(?C), do: ?G
  defp char_to_rna(?T), do: ?A
  defp char_to_rna(?A), do: ?U
end
