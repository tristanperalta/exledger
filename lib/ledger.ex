defmodule ExLedger.Ledger do
  defstruct transactions: []

  alias ExLedger.Transaction

  @type t :: %__MODULE__{
          transactions: [Transaction.t()]
        }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  @spec is_balance?(__MODULE__.t()) :: bool()
  def is_balance?(%{transactions: transactions} = _ledger) do
    Enum.flat_map(transactions, fn txn ->
      Keyword.values(txn.balances)
    end)
    |> Enum.all?(&(&1 == 0))
  end
end
