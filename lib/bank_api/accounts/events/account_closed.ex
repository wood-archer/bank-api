defmodule BankAPI.Accounts.Events.AccountClosed do
  @moduledoc false

  use TypedStruct

  @derive [Jason.Encoder]
  typedstruct do
    field :account_uuid, String.t()
  end
end
