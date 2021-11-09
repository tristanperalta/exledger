defmodule ExLedger.Transaction do
  defstruct [:date, :status, :description, entries: []]

  alias ExLedger.Entry

  @type t :: %__MODULE__{
          date: DateTime.t(),
          status: bool(),
          description: String.t(),
          entries: [Entry.t()]
        }

  def new(), do: new(%{})
  def new(desc) when is_binary(desc), do: new(%{description: desc})

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  def add_entry(%{entries: entries} = txn, account, amount) do
    Map.put(txn, :entries, [Entry.new(account, amount) | entries])
  end

  def transactions(entries) do
    entries
    |> Enum.map(& &1.entries)
    |> List.flatten()
  end

  def balance(%{entries: entries}) do
    entries
    |> Enum.group_by(fn entry -> entry.amount.currency end)
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
