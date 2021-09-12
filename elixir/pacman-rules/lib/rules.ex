defmodule Rules do
  @spec eat_ghost?(boolean, boolean) :: boolean
  def eat_ghost?(_power_pellet_active = true, _touching_ghost = true), do: true
  def eat_ghost?(_power_pellet_active, _touching_ghost), do: false

  @spec score?(boolean, boolean) :: boolean
  def score?(touching_power_pellet, touching_dot) do
    touching_power_pellet or touching_dot
  end

  @spec lose?(boolean, boolean) :: boolean
  def lose?(_power_pellet_active = false, _touching_ghost = true), do: true
  def lose?(_power_pellet_active, _touching_ghost), do: false

  @spec win?(boolean, boolean, boolean) :: boolean
  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
  end
end
