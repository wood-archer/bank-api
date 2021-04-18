defmodule BankAPI.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias BankAPI.{Repo, Router}

  alias BankAPI.Accounts.{
    Commands.OpenAccount,
    Projections.Account
  }

  def get_account(uuid), do: Repo.get!(Account, uuid)

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
            current_balance: initial_balance
          }
        }

      reply ->
        reply
    end
  end

  def open_account(_params), do: {:error, :bad_command}
end
