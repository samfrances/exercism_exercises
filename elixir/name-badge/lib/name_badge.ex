defmodule NameBadge do
  def print(id, name, department) when is_nil(department) do
    print(id, name, "owner")
  end

  def print(id, name, department) do
    id_string =
      if id == nil do "" else "[#{id}] - " end

    "#{id_string}#{name} - #{department |> String.upcase()}"
  end

 end
