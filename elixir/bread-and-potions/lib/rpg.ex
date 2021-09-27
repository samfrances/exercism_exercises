defmodule RPG do
  defmodule Character do
    @type t :: %__MODULE__{health: number(), mana: number()}

    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    @spec eat(t, RPG.Character.t()) ::
            {byproduct :: any, updated_character :: RPG.Character.t()}
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    @spec eat(%RPG.LoafOfBread{}, RPG.Character.t()) :: {nil, RPG.Character.t()}
    def eat(_item, character) do
      {
        nil,
        %{character | health: character.health + 5}
      }
    end
  end

  defimpl Edible, for: ManaPotion do
    @spec eat(%RPG.ManaPotion{}, RPG.Character.t()) :: {%RPG.EmptyBottle{}, RPG.Character.t()}
    def eat(%RPG.ManaPotion{strength: strength}, character = %RPG.Character{mana: mana}) do
      {
        %RPG.EmptyBottle{},
        %{character | mana: mana + strength}
      }
    end
  end

  defimpl Edible, for: Poison do
    @spec eat(%RPG.Poison{}, RPG.Character.t()) :: {%RPG.EmptyBottle{}, RPG.Character.t()}
    def eat(_poison, character) do
      {
        %RPG.EmptyBottle{},
        %{character | health: 0}
      }
    end
  end
end
