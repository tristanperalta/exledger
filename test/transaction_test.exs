defmodule Exledger.TransactionTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

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
