defmodule BankAPI.ProjectorCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      alias BankAPI.Repo

      import Ecto
      import Ecto.{Changeset, Query}
      import BankAPI.DataCase

      import BankAPI.ProjectorUtils
    end
  end

  setup _tags do
    :ok = BankAPI.ProjectorUtils.truncate_database()

    :ok
  end
end
