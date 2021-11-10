defmodule Exledger.TransactionTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  test "add_entry" do
    assert %{balances: [usd: 1]} =
             Transaction.new(%{description: "Test"})
             |> Transaction.add_entry("assets", {1, :usd})
  end

  test "add_entry sum 2 common currency" do
    assert %{balances: [usd: 6]} =
             Transaction.new(%{description: "Test"})
             |> Transaction.add_entry("assets", {1, :usd})
             |> Transaction.add_entry("assets", {5, :usd})
  end

  test "compute balances" do
  end

  test "Transaction.balance/1" do
    transaction =
      Transaction.new(%{description: "Test"})
      |> Transaction.add_entry("assets", {1, :USD})
      |> Transaction.add_entry("expenses", {-1, :USD})
      |> Transaction.add_entry("assets", {1, :PHP})
      |> Transaction.add_entry("expenses", {-1, :PHP})
      |> Transaction.balance()

    assert [USD: 0, PHP: 0] == transaction
  end
end
