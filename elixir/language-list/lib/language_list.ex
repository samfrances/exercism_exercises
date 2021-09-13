defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([]), do: []
  def remove(list) do
    [_first | rest] = list
    rest
  end

  def first(list) do
    [first | _rest] = list
    first
  end

  def count(list) do
    Enum.count(list)
  end

  def exciting_list?(list) do
    "Elixir" in list
  end
end
