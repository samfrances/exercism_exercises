defmodule DNA do

  @type nucleotide :: ?A | ?C | ?G | ?T
  @type space :: ?\s
  @type encoded_nucleotide :: 1 | 2 | 4 | 8
  @type encoded_space :: 0

  @spec encode_nucleotide(nucleotide|space) :: encoded_nucleotide|encoded_space
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  @spec decode_nucleotide(encoded_nucleotide|encoded_space) :: nucleotide|space
  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  @spec encode([nucleotide|space]) :: bitstring
  def encode(dna) do
    dna
    |> Enum.reverse()
    |> encode_tail(<<>>)
  end

  defp encode_tail([], result), do: result
  defp encode_tail([first|rest], result) do
    encoded_first = encode_nucleotide(first)
    encode_tail(rest, << encoded_first::4, result::bitstring >>)
  end

  @spec decode(bitstring) :: [nucleotide|space]
  def decode(dna) do
    decode_tail(dna, [])
    |> Enum.reverse()
  end

  defp decode_tail(<<>>, result), do: result
  defp decode_tail(<<first::4, rest::bitstring>>, result) do
    decode_tail(rest, [decode_nucleotide(first) | result])
  end
end
