defmodule BankAPI.Accounts.Commands.CloseAccount do
  @moduledoc false

  use TypedStruct

  alias BankAPI.Accounts

  typedstruct do
    field :account_uuid, String.t(), enforce: true
  end

  def valid?(command) do
    Skooma.valid?(Map.from_struct(command), schema())
  end

  defp schema do
    %{account_uuid: [:string, Skooma.Validators.regex(Accounts.uuid_regex())]}
  end
end
