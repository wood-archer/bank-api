defmodule BankAPI.AccountControllerTest do
  use BankAPIWeb.ConnCase

  @create_attrs %{
    initial_balance: 42_00
  }
  @invalid_attrs %{
    initial_balance: nil
  }

  setup %{conn: conn} do
    {:ok, %{conn: put_req_header(conn, "accept", "application/json")}}
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      path = Routes.account_path(conn, :create)
      params = %{account: @create_attrs}
      request = post(conn, path, params)
      response = json_response(request, 201)

      assert %{
               "data" => %{
                 "uuid" => _uuid,
                 "current_balance" => 4200
               }
             } = response
    end

    test "renders error when data is invalid", %{conn: conn} do
      path = Routes.account_path(conn, :create)
      params = %{account: @invalid_attrs}
      request = post(conn, path, params)
      response = json_response(request, 422)

      assert %{"errors" => _} = response
    end
  end
end
