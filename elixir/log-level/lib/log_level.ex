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

  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? -> @unknown
      level == 0             -> @trace
      level == 1             -> @debug
      level == 2             -> @info
      level == 3             -> @warning
      level == 4             -> @error
      level == 5 and legacy? -> @unknown
      level == 5             -> @fatal
      true                   -> @unknown
    end
  end

  def alert_recipient(level, legacy?) do
    level
    |> to_label(legacy?)
    |> route_by_level_name(legacy?)
  end

  def route_by_level_name(name, legacy?) do
    cond do
      name == @fatal or name == @error -> @opsteam
      name == @unknown and legacy?     -> @devteam1
      name == @unknown                 -> @devteam2
      true                             -> nil
    end
  end

end
