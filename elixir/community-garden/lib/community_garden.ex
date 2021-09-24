# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]

  @type t :: %__MODULE__{
          plot_id: non_neg_integer,
          registered_to: String.t()
        }

  @spec new(non_neg_integer, String.t()) :: __MODULE__.t()
  def new(id, name) do
    %__MODULE__{plot_id: id, registered_to: name}
  end
end

defmodule GardenRegistry do
  defstruct next_plot_id: 0,
            registrations: []

  @type t :: %__MODULE__{
          next_plot_id: non_neg_integer,
          registrations: [Plot.t()]
        }

  @spec new :: __MODULE__.t()
  def new() do
    %__MODULE__{}
  end

  @spec registrations(__MODULE__.t()) :: [Plot.t()]
  def registrations(%__MODULE__{registrations: reg}) do
    reg
  end

  @spec register(__MODULE__.t(), String.t()) :: {Plot.t(), __MODULE__.t()}
  def register(
        %__MODULE__{registrations: reg, next_plot_id: next_id} = registry,
        name
      ) do
    new_plot = Plot.new(next_id, name)

    new_state = %{
      registry
      | next_plot_id: next_id + 1,
        registrations: [new_plot | reg]
    }

    {new_plot, new_state}
  end

  @spec release(__MODULE__.t(), non_neg_integer) :: __MODULE__.t()
  def release(%__MODULE__{registrations: plots} = registry, id) do
    %{
      registry
      | registrations: Enum.filter(plots, fn plot -> plot.plot_id !== id end)
    }
  end

  @spec get_registration(__MODULE__.t(), non_neg_integer) :: {:not_found, String.t()} | Plot.t()
  def get_registration(%__MODULE__{registrations: plots}, id) do
    plots
    |> Enum.find_value(
      {:not_found, "plot is unregistered"},
      fn plot ->
        if plot.plot_id === id, do: plot
      end
    )
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
    Agent.update(pid, GardenRegistry, :release, [plot_id])
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, GardenRegistry, :get_registration, [plot_id])
  end
end
