defmodule BankAPI.Accounts.Projecctors.AccountOpenedTest do
  use BankAPI.ProjectorCase

  alias BankAPI.Accounts.{
    Events.AccountOpened,
    Projections.Account
  }

  alias BankAPI.Accounts.Projectors.AccountOpened, as: Projector

  test "should succeed with valid data" do
    uuid = UUID.uuid4()

    account_opened_event = %AccountOpened{
      account_uuid: uuid,
      initial_balance: 1_000
    }

    last_seen_event_number = get_last_seen_event_number("Accounts.Projectors.AccountOpened")

    assert :ok =
             Projector.handle(
               account_opened_event,
               %{
                 handler_name: "Accounts.Projectors.AccountOpened",
                 event_number: last_seen_event_number + 1
               }
             )

    assert only_instance_of(Account).current_balance == 1_000
    assert only_instance_of(Account).uuid == uuid
  end
end
