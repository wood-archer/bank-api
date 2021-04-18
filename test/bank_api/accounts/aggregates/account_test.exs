defmodule BankAPI.Accounts.Aggregates.AccountTest do
  use BankAPI.InMemoryEventStoreCase

  alias BankAPI.Accounts.{
    Aggregates.Account,
    Commands.OpenAccount,
    Events.AccountOpened
  }

  test "ensures aggregate gets correct state on creation" do
    uuid = UUID.uuid4()

    account =
      evolve(
        %Account{},
        %AccountOpened{
          initial_balance: 1_000,
          account_uuid: uuid
        }
      )

    assert account.uuid == uuid
    assert account.current_balance == 1_000
  end

  test "errors out on invalid opening balance" do
    invalid_command = %OpenAccount{
      initial_balance: -1_000,
      account_uuid: UUID.uuid4()
    }

    assert {:error, :initial_balance_must_be_above_zero} =
             Account.execute(%Account{}, invalid_command)
  end

  test "errors out on already opened account" do
    command = %OpenAccount{
      initial_balance: 1_000,
      account_uuid: UUID.uuid4()
    }

    assert {:error, :account_already_opened} =
             Account.execute(%Account{uuid: UUID.uuid4()}, command)
  end
end
