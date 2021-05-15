defmodule BankAPI.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias BankAPI.{Repo, Router}

  alias BankAPI.Accounts.{
    Commands.CloseAccount,
    Commands.OpenAccount,
    Projections.Account
  }

  @uuid_regex ~r/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

  def open_account(%{"initial_balance" => initial_balance}) do
    account_uuid = UUID.uuid4()

    dispatch_result =
      Router.dispatch(%OpenAccount{
        initial_balance: initial_balance,
        account_uuid: account_uuid
      })

    case dispatch_result do
      :ok ->
        {
          :ok,
          %Account{
            uuid: account_uuid,
            current_balance: initial_balance,
            status: Account.status().open
          }
        }

      reply ->
        reply
    end
  end

  def open_account(_params), do: {:error, :bad_command}

  def get_account(id) do
    case Repo.get(Account, id) do
      %Account{} = account ->
        {:ok, account}

      _reply ->
        {:error, :not_found}
    end
  end

  def close_account(id) do
    Router.dispatch(%CloseAccount{account_uuid: id})
  end

  def uuid_regex, do: @uuid_regex
end
