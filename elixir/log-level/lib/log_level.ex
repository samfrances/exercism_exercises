defmodule LogLevel do
  @trace :trace
  @debug :debug
  @info :info
  @warning :warning
  @error :error
  @fatal :fatal
  @unknown :unknown

  @devteam1 :dev1
  @devteam2 :dev2
  @opsteam :ops

  def to_label(_level = 0, _legacy? = true),  do: @unknown
  def to_label(_level = 0, _legacy?),         do: @trace
  def to_label(_level = 1, _legacy?),         do: @debug
  def to_label(_level = 2, _legacy?),         do: @info
  def to_label(_level = 3, _legacy?),         do: @warning
  def to_label(_level = 4, _legacy?),         do: @error
  def to_label(_level = 5, _legacy? = true),  do: @unknown
  def to_label(_level = 5, _legacy? = false), do: @fatal
  def to_label(_level, _legacy?),             do: @unknown

  def alert_recipient(level, legacy?) do
    level
    |> to_label(legacy?)
    |> route_by_level_name(legacy?)
  end

  def route_by_level_name(@fatal,   _legacy?),        do: @opsteam
  def route_by_level_name(@error,   _legacy?),        do: @opsteam
  def route_by_level_name(@unknown, _legacy? = true), do: @devteam1
  def route_by_level_name(@unknown, _legacy?),        do: @devteam2
  def route_by_level_name(_name,    _legacy?),        do: nil

end
