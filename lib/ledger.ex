defmodule ExLedger.Ledger do

  defstruct entries: []

  alias ExLedger.Entry

  @type t :: %__MODULE__{
    entries: [Entry.t()],
  }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  @spec balance(__MODULE__.t()) :: integer()
  def balance(%{entries: entries} = _ledger) do
    entries
    |> Entry.transactions()
    |> sum()
  end

  def sum(transactions) do
    transactions
    |> Enum.group_by(fn(txn) -> txn.amount.currency end)
    |> Enum.map(fn({_c, txns}) ->
      txns
      |> Enum.map(&(&1.amount.quantity))
      |> Enum.sum()
    end)
    |> Enum.sum()
  end
end
