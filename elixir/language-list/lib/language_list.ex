defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([]), do: []
  def remove([_first | rest]) do
    rest
  end

  def first([first | _rest]) do
    first
  end

  def count(list) do
    Enum.count(list)
  end

  def exciting_list?(list) do
    "Elixir" in list
  end
end
