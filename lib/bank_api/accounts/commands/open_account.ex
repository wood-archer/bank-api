defmodule BankAPI.Accounts.Commands.OpenAccount do
  @moduledoc false

  alias BankAPI.Accounts
  alias BankAPI.Accounts.Commands.Validators

  use TypedStruct

  typedstruct do
    field :account_uuid, String.t(), enforce: true
    field :initial_balance, integer()
  end

  def valid?(command) do
    Skooma.valid?(Map.from_struct(command), schema())
  end

  defp schema do
    %{
      account_uuid: [:string, Skooma.Validators.regex(Accounts.uuid_regex())],
      initial_balance: [:int, &Validators.positive_integer(&1)]
    }
  end
end
