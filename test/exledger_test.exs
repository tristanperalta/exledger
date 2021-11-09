defmodule ExledgerTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  test "Ledger.balance/1" do
    transaction =
      Transaction.new(%{description: "Test"})
      |> Transaction.add_entry("assets", {1, :USD})
      |> Transaction.add_entry("expensese", {-1, :USD})
      |> Transaction.add_entry("assets", {1, :PHP})
      |> Transaction.add_entry("expenses", {-1, :PHP})

    ledger = Ledger.new(transactions: [transaction])

    assert Ledger.balance(ledger) == 0
  end
end
