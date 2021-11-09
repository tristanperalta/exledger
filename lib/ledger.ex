defmodule ExLedger.Ledger do
  defstruct transactions: []

  alias ExLedger.Transaction

  @type t :: %__MODULE__{
          transactions: [Transaction.t()]
        }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  @spec balance(__MODULE__.t()) :: integer()
  def balance(%{transactions: transactions} = _ledger) do
    transactions
    |> Enum.reduce(0, fn totals, acc ->
      totals =
        totals
        |> Transaction.balance()
        |> Keyword.values()
        |> Enum.sum()

      acc + totals
    end)
  end
end
