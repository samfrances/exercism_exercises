defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_fingerprint = fingerprint(base)
    candidates
    |> Stream.reject(& String.downcase(&1) == String.downcase(base))
    |> Stream.map(fn candidate -> {candidate, fingerprint(candidate)} end)
    |> Stream.filter(fn {_candidate, fingerprint} -> fingerprint == base_fingerprint end)
    |> Stream.map(& elem(&1, 0))
    |> Enum.to_list()
  end

  defp fingerprint(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

end
