defmodule RemoteControlCar do

  @type t :: %__MODULE__{
    battery_percentage: non_neg_integer,
    distance_driven_in_meters: non_neg_integer,
    nickname: String.t
  }

  @enforce_keys [:nickname]
  defstruct [
    battery_percentage: 100,
    distance_driven_in_meters: 0,
    nickname: nil
  ]

  @spec new(String.t) :: RemoteControlCar.t
  def new(nickname \\ "none") do
    %__MODULE__{nickname: nickname}
  end

  @spec display_distance(RemoteControlCar.t) :: String.t
  def display_distance(%__MODULE__{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  @spec display_battery(RemoteControlCar.t) :: String.t
  def display_battery(%__MODULE__{battery_percentage: battery}) do
    format_battery(battery)
  end

  defp format_battery(0), do: "Battery empty"
  defp format_battery(n), do: "Battery at #{n}%"

  @spec drive(RemoteControlCar.t) :: RemoteControlCar.t
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
