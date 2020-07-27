defmodule ExLedger.Entry do
  defstruct [:date, :status, :description, transactions: []]

  alias ExLedger.Transaction

  @type t :: %__MODULE__{
          date: DateTime.t(),
          status: bool(),
          description: String.t(),
          transactions: [Transaction.t()]
        }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  def transactions(entries) do
    entries
    |> Enum.map(& &1.transactions)
    |> List.flatten()
  end

  def balance(%{transactions: transactions}) do
    transactions
    |> Enum.group_by(fn txn -> txn.amount.currency end)
    |> Enum.reduce([], fn {currency, txns} = _entry, acc ->
      Keyword.put(
        acc,
        currency,
        txns
        |> Enum.map(& &1.amount.quantity)
        |> Enum.sum()
      )
    end)
  end
end
