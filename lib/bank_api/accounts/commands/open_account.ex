defmodule BankAPI.Accounts.Commands.OpenAccount do
  @moduledoc false

  use TypedStruct

  typedstruct do
    field :account_uuid, String.t(), enforce: true
    field :initial_balance, integer()
  end
end
