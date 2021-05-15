defmodule BankAPI.Accounts.Supervisor do
  @moduledoc false

  use Supervisor

  alias BankAPI.Accounts.Projectors.{AccountClosed, AccountOpened}

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_) do
    children = [
      Supervisor.child_spec({AccountOpened, []}, id: :account_opened),
      Supervisor.child_spec({AccountClosed, []}, id: :account_closed)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
