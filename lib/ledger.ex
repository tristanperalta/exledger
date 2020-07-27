defmodule ExLedger.Ledger do
  defstruct entries: []

  alias ExLedger.Entry

  @type t :: %__MODULE__{
          entries: [Entry.t()]
        }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  @spec balance(__MODULE__.t()) :: integer()
  def balance(%{entries: entries} = _ledger) do
    entries
    |> Enum.reduce(0, fn totals, acc ->
      totals =
        totals
        |> Entry.balance()
        |> Keyword.values()
        |> Enum.sum()

      acc + totals
    end)
  end
end
