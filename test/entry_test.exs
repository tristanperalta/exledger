defmodule Exledger.EntryTest do
  use ExUnit.Case
  use ExLedger.LedgerBuilder

  test "Entry.balance/1" do
    txn1 = build_transaction("assets", {1, :USD})
    txn2 = build_transaction("expenses", {-1, :USD})
    txn3 = build_transaction("assets", {1, :PHP})
    txn4 = build_transaction("expenses", {-1, :PHP})

    entry = Entry.new(
      date: DateTime.utc_now(),
      transactions: [txn1, txn2, txn3, txn4])
    assert Entry.balance(entry) == [USD: 0, PHP: 0]
  end
end
