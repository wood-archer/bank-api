defmodule BankAPI.App do
  @moduledoc false

  use Commanded.Application, otp_app: :bank_api

  router(BankAPI.Router)
end
