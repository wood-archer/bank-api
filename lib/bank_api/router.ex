defmodule BankAPI.Router do
  use Commanded.Commands.Router, application: BankAPI.App

  alias BankAPI.Accounts.{
    Aggregates.Account,
    Commands.CloseAccount,
    Commands.OpenAccount
  }

  middleware(BankAPI.Middleware.ValidateCommand)

  dispatch([OpenAccount, CloseAccount], to: Account, identity: :account_uuid)
end
