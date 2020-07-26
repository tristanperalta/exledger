defmodule ExledgerTest do
  use ExUnit.Case

  alias ExLedger.{Ledger, Entry, Transaction, Account, Amount}

  test "Ledger.balance/1" do
    account = Account.new(name: "assets")
    amount = Amount.new(quantity: 1, currency: :USD)
    txn1 = Transaction.new(account: account, amount: amount)

    account2 = Account.new(name: "expenses")
    amount2 = Amount.new(quantity: -1, currency: :USD)
    txn2 = Transaction.new(account: account2, amount: amount2)

    entry = Entry.new(date: DateTime.utc_now(), transactions: [txn1, txn2])

    ledger = Ledger.new(entries: [entry])

    # IO.inspect(ledger)
    assert Ledger.balance(ledger) == 0
  end
end
