defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @alphabet ?a..?z |> Enum.to_list() |> Enum.map(& <<&1>>) |> MapSet.new()

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    letters =
      sentence
      |> String.downcase()
      |> String.codepoints()
      |> MapSet.new()
    MapSet.subset?(@alphabet, letters)
  end
end
