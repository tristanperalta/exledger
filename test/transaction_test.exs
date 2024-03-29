defmodule ExLedger.TransactionTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  alias Decimal, as: D

  describe "add_entry/3" do
    setup :build_transaction

    test "single currency", %{transaction: txn} do
      assert %{balances: %{usd: %D{coef: 1}}} = txn
    end

    test "sums 2 common currency", %{transaction: txn} do
      assert %{balances: %{usd: %D{coef: 6}}} =
               txn
               |> Transaction.add_entry("assets", {5, :usd})
    end

    test "multiple currency", %{transaction: txn} do
      assert %{balances: %{usd: %D{coef: 0}, php: %D{coef: 0}}} =
               txn
               |> Transaction.add_entry("expenses", {-1, :usd})
               |> Transaction.add_entry("assets", {1, :php})
               |> Transaction.add_entry("expenses", {-1, :php})
    end
  end

  describe "balanced?/1" do
    test "returns true when all balances is 0" do
      txn =
        Transaction.new("test transaction")
        |> Transaction.add_entry("assets", {-100, :usd})
        |> Transaction.add_entry("expenses", {100, :usd})

      assert Transaction.balanced?(txn)
    end

    test "returns false when all imbalances is 0" do
      txn =
        Transaction.new("test transaction")
        |> Transaction.add_entry("assets", {-100, :usd})

      refute Transaction.balanced?(txn)
    end
  end

  defp build_transaction(_context) do
    transaction =
      Transaction.new("test transaction")
      |> Transaction.add_entry("assets", {1, :usd})

    [transaction: transaction]
  end
end
