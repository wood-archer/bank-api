defmodule BankAPI.Router do
  use Commanded.Commands.Router, application: BankAPI.App

  alias BankAPI.Accounts.{Aggregates.Account, Commands.OpenAccount}

  middleware(BankAPI.Middleware.ValidateCommand)

  dispatch([OpenAccount], to: Account, identity: :account_uuid)
end
