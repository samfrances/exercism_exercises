defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    Enum.to_list(rank_range())
  end

  def files do
    file_range()
    |> Enum.map(& [&1])
    |> Enum.map(&List.to_string/1)
    |> Enum.to_list()
  end
end
