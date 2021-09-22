defmodule BasketballWebsite do
  @spec extract_from_path(Map.t, String.t) :: any
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> Enum.reduce_while(data, &traverse/2)
  end

  defp traverse(key, data) do
    next = data[key]
    {
      (if is_nil(next), do: :halt, else: :cont),
      next
    }
  end

  @spec get_in_path(Map.t, String.t) :: any
  def get_in_path(data, path) do
    path
    |> String.split(".")
    |> then(& get_in data, &1)
  end
end
