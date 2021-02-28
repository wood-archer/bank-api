defmodule BankAPI.Accounts.Events.AccountOpened do
  @moduledoc false

  use TypedStruct

  @derive [Jason.Encoder]

  typedstruct do
    field :account_uuid, String.t()
    field :initial_balance, integer()
  end
end
