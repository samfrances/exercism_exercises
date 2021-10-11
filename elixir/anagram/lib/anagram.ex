defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_fingerprint = fingerprint(base)
    candidates
    |> Enum.reject(& String.downcase(&1) == String.downcase(base))
    |> Enum.map(&with_fingerprint/1)
    |> Enum.filter(fingerprint_equals(base_fingerprint))
    |> Enum.map(&without_fingerprint/1)
  end

  defp fingerprint(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

  defp with_fingerprint(str) do
    {str, fingerprint(str)}
  end

  defp without_fingerprint({str, _fingerprint}) do
    str
  end

  defp fingerprint_equals(fingerprint) do
    fn {_str, other_fingerprint} ->
      fingerprint === other_fingerprint
    end
  end

end
