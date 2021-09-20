defmodule NameBadge do
  def print(id, name, department) do
    # Solved using if-expressions, as an exercise in their use
    department_name =
      if department == nil do "owner" else department end
      |> String.upcase()

    id_string =
      if id == nil do "" else "[#{id}] - " end

    "#{id_string}#{name} - #{department_name}"
  end
end
