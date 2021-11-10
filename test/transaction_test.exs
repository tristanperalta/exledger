defmodule Exledger.TransactionTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  test "add_entry/3" do
    assert %{balances: [usd: 1]} =
             Transaction.new("test transaction")
             |> Transaction.add_entry("assets", {1, :usd})
  end

  test "add_entry/3 sum 2 common currency" do
    assert %{balances: [usd: 6]} =
             Transaction.new("test transaction")
             |> Transaction.add_entry("assets", {1, :usd})
             |> Transaction.add_entry("assets", {5, :usd})
  end

  test "compute balances" do
  end

  test "add_entry/3 with multiple currency" do
    assert %{balances: [usd: 0, php: 0]} =
             Transaction.new("test transaction")
             |> Transaction.add_entry("assets", {1, :usd})
             |> Transaction.add_entry("expenses", {-1, :usd})
             |> Transaction.add_entry("assets", {1, :php})
             |> Transaction.add_entry("expenses", {-1, :php})
  end
end
