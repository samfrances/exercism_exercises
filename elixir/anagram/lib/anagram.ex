defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_fingerprint = fingerprint(base)
    candidates
    |> Enum.reject(& String.downcase(&1) == String.downcase(base))
    |> Enum.filter(& anagram?(&1, base_fingerprint))
  end

  defp anagram?(word, fingerprint) do
    fingerprint(word) == fingerprint
  end

  defp fingerprint(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

end
