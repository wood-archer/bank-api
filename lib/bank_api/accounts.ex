defmodule BankAPI.Accounts do
  # The Accounts context.

  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias BankAPI.{Repo, Router}

  alias BankAPI.Accounts.{
    Commands.OpenAccount,
    Projections.Account
  }

  def get_account(uuid), do: Repo.get!(Account, uuid)

  def open_account(attrs) do
    changeset = account_opening_changeset(attrs)

    if changeset.valid? do
      account_uuid = UUID.uuid4()

      dispatch_result =
        %OpenAccount{
          initial_balance: changeset.changes.initial_balance,
          account_uuid: account_uuid
        }
        |> Router.dispatch()

      case dispatch_result do
        :ok ->
          {:ok,
           %Account{
             uuid: account_uuid,
             current_balance: changeset.changes.initial_balance
           }}

        reply ->
          reply
      end
    else
      {:validation_error, changeset}
    end
  end

  defp account_opening_changeset(params) do
    {
      params,
      %{initial_balance: :integer}
    }
    |> Changeset.cast(params, [:initial_balance])
    |> Changeset.validate_required([:initial_balance])
    |> Changeset.validate_number(:initial_balance, greater_than: 0)
  end
end
