defmodule BankAPI.Accounts.Commands.OpenAccount do
  @moduledoc false

  @uuid_regex ~r/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

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
      account_uuid: [:string, Skooma.Validators.regex(@uuid_regex)],
      initial_balance: [:int, &positive_integer(&1)]
    }
  end

  defp positive_integer(data) when is_integer(data) and data > 0, do: :ok
  defp positive_integer(data) when data <= 0, do: {:error, "Argument must be bigger than zero"}
  defp positive_integer(_), do: {:error, "Argument must be an integer."}
end
