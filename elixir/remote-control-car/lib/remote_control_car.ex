defmodule RemoteControlCar do

  @enforce_keys [:nickname]
  defstruct [
    battery_percentage: 100,
    distance_driven_in_meters: 0,
    nickname: nil
  ]

  def new() do
    %__MODULE__{nickname: "none"}
  end

  def new(nickname) do
    %__MODULE__{nickname: nickname}
  end

  def display_distance(%__MODULE__{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%__MODULE__{battery_percentage: battery}) do
    format_battery(battery)
  end

  defp format_battery(0), do: "Battery empty"
  defp format_battery(n), do: "Battery at #{n}%"

  def drive(car = %__MODULE__{battery_percentage: 0}) do
    car
  end
  def drive(car = %__MODULE__{}) do
    %{
      car |
      distance_driven_in_meters: car.distance_driven_in_meters + 20,
      battery_percentage: car.battery_percentage - 1
    }
  end
end
