defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(BankAccount.Server, nil)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none()
  def close_bank(account) do
    GenServer.cast(account, :close)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:update, amount})
  end

  defmodule Account do
    defstruct [balance: 0, closed: false]

    @type t :: %__MODULE__{
      balance: number(),
      closed: boolean()
    }

    @spec update(BankAccount.Account.t(), any) ::
            {:error, :account_closed} | BankAccount.Account.t()
    def update(%__MODULE__{closed: true}, _amount) do
      account_closed_error()
    end
    def update(account = %__MODULE__{balance: balance}, amount) do
      %{ account | balance: balance + amount }
    end

    @spec balance(BankAccount.Account.t()) :: {:error, :account_closed}|number()
    def balance(%__MODULE__{closed: true}) do
      account_closed_error()
    end
    def balance(%__MODULE__{balance: balance}) do
      balance
    end

    @spec close(BankAccount.Account.t()) :: BankAccount.Account.t()
    def close(account= %__MODULE__{}) do
      %{ account | closed: true }
    end

    defp account_closed_error() do
      {:error, :account_closed}
    end
  end

  defmodule Server do
    use GenServer

    @impl true
    def init(_) do
      {:ok, %BankAccount.Account{}}
    end

    @impl true
    def handle_call(:balance, _from, account) do
      {:reply, BankAccount.Account.balance(account), account }
    end

    @impl true
    def handle_call({:update, amount}, _from, account) do
      newstate = BankAccount.Account.update(account, amount)
      { :reply, newstate, newstate }
    end

    @impl true
    def handle_cast(:close, account) do
      { :noreply, BankAccount.Account.close(account) }
    end
  end

end
