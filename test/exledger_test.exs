defmodule ExLedgerTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  test "Ledger.is_balanced?/1" do
    transaction =
      Transaction.new("test transaction")
      |> Transaction.add_entry("assets", {1, :USD})
      |> Transaction.add_entry("expensese", {-1, :USD})
      |> Transaction.add_entry("assets", {1, :PHP})
      |> Transaction.add_entry("expenses", {-1, :PHP})

    ledger = Ledger.new(transactions: [transaction])

    assert Ledger.is_balanced?(ledger)
  end

  test "Ledger.is_balanced?/1 imbalance" do
    transaction =
      Transaction.new("test transaction")
      |> Transaction.add_entry("assets", {1, :USD})
      |> Transaction.add_entry("expensese", {-1, :USD})
      |> Transaction.add_entry("assets", {1, :PHP})

    ledger = Ledger.new(transactions: [transaction])

    assert false == Ledger.is_balanced?(ledger)
  end
end
