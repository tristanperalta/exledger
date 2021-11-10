defmodule ExledgerTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  test "Ledger.is_balance?/1" do
    transaction =
      Transaction.new("test transaction")
      |> Transaction.add_entry("assets", {1, :USD})
      |> Transaction.add_entry("expensese", {-1, :USD})
      |> Transaction.add_entry("assets", {1, :PHP})
      |> Transaction.add_entry("expenses", {-1, :PHP})

    ledger = Ledger.new(transactions: [transaction])

    assert Ledger.is_balance?(ledger)
  end

  test "Ledger.is_balance?/1 imbalance" do
    transaction =
      Transaction.new("test transaction")
      |> Transaction.add_entry("assets", {1, :USD})
      |> Transaction.add_entry("expensese", {-1, :USD})
      |> Transaction.add_entry("assets", {1, :PHP})

    ledger = Ledger.new(transactions: [transaction])

    assert false == Ledger.is_balance?(ledger)
  end
end
