# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]

  def new(id, name) do
    %Plot{plot_id: id, registered_to: name}
  end
end

defmodule GardenRegistry do
  defstruct [
    next_plot_id: 0,
    registrations: []
  ]

  @spec new :: %GardenRegistry{next_plot_id: 0, registrations: []}
  def new() do
    %__MODULE__{}
  end

  def registrations(%__MODULE__{registrations: reg}) do
    reg
  end

  def register(
    %__MODULE__{registrations: reg, next_plot_id: next_id} = registry,
    name
  ) do
    new_plot = Plot.new(next_id, name)
    new_state = %{
      registry |
      next_plot_id: next_id + 1,
      registrations: [new_plot | reg]
    }
    {new_plot, new_state}
  end
end

defmodule CommunityGarden do
  def start() do
    Agent.start(&GardenRegistry.new/0)
  end

  def list_registrations(pid) do
    Agent.get(pid, &GardenRegistry.registrations/1)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, GardenRegistry, :register, [register_to])
  end

  def release(pid, plot_id) do
    # Please implement the release/2 function
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
  end
end
