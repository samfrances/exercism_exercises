defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    ~r/(\s|\-+|_+)/
    |> Regex.split(string, trim: true)
    |> Enum.map(
      &(&1
        |> String.first()
        |> String.upcase())
    )
    |> Enum.join("")
  end
end
