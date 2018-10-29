defmodule ChallengePlayerWeb.CheckoutControllerTest do
  use ChallengePlayerWeb.ConnCase

  alias ChallengePlayer.Api
  alias ChallengePlayer.Api.Checkout

  @create_attrs %{id: 42}
  @update_attrs %{id: 43}
  @invalid_attrs %{id: nil}

  def fixture(:checkout) do
    {:ok, checkout} = Api.create_checkout(@create_attrs)
    checkout
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all checkouts", %{conn: conn} do
      conn = get conn, checkout_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create checkout" do
    test "renders checkout when data is valid", %{conn: conn} do
      conn = post conn, checkout_path(conn, :create), checkout: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, checkout_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "id" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, checkout_path(conn, :create), checkout: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update checkout" do
    setup [:create_checkout]

    test "renders checkout when data is valid", %{conn: conn, checkout: %Checkout{id: id} = checkout} do
      conn = put conn, checkout_path(conn, :update, checkout), checkout: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, checkout_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "id" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, checkout: checkout} do
      conn = put conn, checkout_path(conn, :update, checkout), checkout: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete checkout" do
    setup [:create_checkout]

    test "deletes chosen checkout", %{conn: conn, checkout: checkout} do
      conn = delete conn, checkout_path(conn, :delete, checkout)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, checkout_path(conn, :show, checkout)
      end
    end
  end

  defp create_checkout(_) do
    checkout = fixture(:checkout)
    {:ok, checkout: checkout}
  end
end
