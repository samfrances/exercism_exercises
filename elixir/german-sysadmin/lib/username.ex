defmodule Username do

  @spec sanitize(charlist) :: charlist
  def sanitize(username) do
    username
    |> Enum.flat_map(&translate_german_char/1)
    |> Enum.filter(&is_permitted_char/1)
  end

  defp translate_german_char(ch) do
    case ch do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      c -> [c]
    end
  end

  defp is_permitted_char(ch) do
    case ch do
      ?_ -> true
      ch when ch in ?a..?z -> true
      _ -> false
    end
  end
end
