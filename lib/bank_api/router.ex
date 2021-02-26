defmodule BankAPI.Router do
  use Commanded.Commands.Router

  alias BankAPI.Accounts.Aggregates.Account
  alias BankAPI.Accounts.Commands.OpenAccount

  dispatch([OpenAccount], to: Account, function: :open_account, identity: :account_uuid)
end
