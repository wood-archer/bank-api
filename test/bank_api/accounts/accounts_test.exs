defmodule BankAPI.Accounts.AccountsTest do
  use BankAPI.InMemoryEventStoreCase

  alias BankAPI.Accounts
  alias BankAPI.Accounts.Projections.Account

  test "opens account with valid command" do
    params = %{
      "initial_balance" => 1_000
    }

    assert {:ok, %Account{current_balance: 1_000}} = Accounts.open_account(params)
  end

  test "does not dispatch command with invalid payload" do
    params = %{"bad_key" => 1_000}

    assert {:error, :bad_command} = Accounts.open_account(params)
  end

  test "returns validation errors from dispatch" do
    params_0 = %{"initial_balance" => "1_000"}
    params_1 = %{"initial_balance" => -10}
    params_2 = %{"initial_balance" => 0}

    assert {:error, :command_validation_failure, _cmd,
            ["Expected INTEGER, got STRING \"1_000\", at initial_balance"]} =
             Accounts.open_account(params_0)

    assert {:error, :command_validation_failure, _cmd, ["Argument must be bigger than zero."]} =
             Accounts.open_account(params_1)

    assert {:error, :command_validation_failure, _cmd, ["Argument must be bigger than zero."]} =
             Accounts.open_account(params_2)
  end
end
