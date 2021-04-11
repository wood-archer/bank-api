defmodule BankAPI.AggregateUtils do
  @moduledoc false

  def evolve(aggregate, events) do
    Enum.reduce(
      List.wrap(events),
      aggregate,
      &aggregate.__struct__.apply(&1, &2)
    )
  end
end
