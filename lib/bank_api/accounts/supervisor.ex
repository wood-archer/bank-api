defmodule BankAPI.Accounts.Supervisor do
  @moduledoc false

  use Supervisor

  alias BankAPI.Accounts.Projectors.AccountOpened

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_) do
    children = [
      Supervisor.child_spec({AccountOpened, []}, id: :account_opened)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
