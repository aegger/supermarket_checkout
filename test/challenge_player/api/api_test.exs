defmodule ChallengePlayer.ApiTest do
  use ChallengePlayer.DataCase

  alias ChallengePlayer.Api

  describe "checkouts" do
    alias ChallengePlayer.Api.Checkout

    @valid_attrs %{id: 42}
    @update_attrs %{id: 43}
    @invalid_attrs %{id: nil}

    def checkout_fixture(attrs \\ %{}) do
      {:ok, checkout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_checkout()

      checkout
    end

    test "list_checkouts/0 returns all checkouts" do
      checkout = checkout_fixture()
      assert Api.list_checkouts() == [checkout]
    end

    test "get_checkout!/1 returns the checkout with given id" do
      checkout = checkout_fixture()
      assert Api.get_checkout!(checkout.id) == checkout
    end

    test "create_checkout/1 with valid data creates a checkout" do
      assert {:ok, %Checkout{} = checkout} = Api.create_checkout(@valid_attrs)
      assert checkout.id == 42
    end

    test "create_checkout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_checkout(@invalid_attrs)
    end

    test "update_checkout/2 with valid data updates the checkout" do
      checkout = checkout_fixture()
      assert {:ok, checkout} = Api.update_checkout(checkout, @update_attrs)
      assert %Checkout{} = checkout
      assert checkout.id == 43
    end

    test "update_checkout/2 with invalid data returns error changeset" do
      checkout = checkout_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_checkout(checkout, @invalid_attrs)
      assert checkout == Api.get_checkout!(checkout.id)
    end

    test "delete_checkout/1 deletes the checkout" do
      checkout = checkout_fixture()
      assert {:ok, %Checkout{}} = Api.delete_checkout(checkout)
      assert_raise Ecto.NoResultsError, fn -> Api.get_checkout!(checkout.id) end
    end

    test "change_checkout/1 returns a checkout changeset" do
      checkout = checkout_fixture()
      assert %Ecto.Changeset{} = Api.change_checkout(checkout)
    end
  end
end
