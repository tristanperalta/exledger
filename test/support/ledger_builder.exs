defmodule ExLedger.LedgerBuilder do

  defmacro __using__(_options) do
    quote do
      alias ExLedger.{Ledger, Account, Amount, Transaction, Entry}
      import ExLedger.LedgerBuilder, only: :functions
    end
  end

  alias ExLedger.{Ledger, Account, Amount, Transaction, Entry}

  def account_fields(overrides) do
    Keyword.merge([name: "assets"], overrides)
  end

  def build_account(account_overrides \\ []) do
    account_overrides
    |> account_fields()
    |> Account.new()
  end

  def amount_fields(overrides) do
    Keyword.merge([quantity: 1, currency: :USD], overrides)
  end

  def build_amount(amount_overrides \\ []) do
    amount_overrides
    |> amount_fields()
    |> Amount.new()
  end

  def transaction_fields(overrides) do
    Keyword.merge([
      account: build_account(),
      amount: build_amount()], overrides)
  end

  def build_transaction(account_name, {qty, cur} = _amount_in_tuple) do
    account = build_account(name: account_name)
    amount = build_amount(quantity: qty, currency: cur)

    transaction_fields(account: account, amount: amount)
    |> Transaction.new()
  end
end
