defmodule ExLedger.Ledger do
  defstruct transactions: []

  alias ExLedger.Transaction

  @type t :: %__MODULE__{
          transactions: [Transaction.t()]
        }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  @spec is_balanced?(__MODULE__.t()) :: bool()
  def is_balanced?(%{transactions: transactions} = _ledger) do
    Enum.map(transactions, &Transaction.is_balanced?/1)
    |> Enum.all?()
  end
end
