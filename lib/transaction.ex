defmodule ExLedger.Transaction do
  defstruct [:date, :status, :description, balances: [], entries: []]

  alias ExLedger.Entry

  @type t :: %__MODULE__{
          date: DateTime.t(),
          status: bool(),
          description: String.t(),
          balances: keyword(),
          entries: [Entry.t()]
        }

  def new(), do: new(%{})
  def new(desc) when is_binary(desc), do: new(%{description: desc})

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  def add_entry(%{entries: entries} = txn, account, amount) do
    txn
    |> Map.put(:entries, [Entry.new(account, amount) | entries])
    |> compute_balance(amount)
  end

  def update_balance(balances, {qty, curr}) do
    Keyword.update(balances, curr, qty, fn e -> e + qty end)
  end

  def compute_balance(txn, amount) do
    Map.put(txn, :balances, update_balance(txn.balances, amount))
  end

  def transactions(entries) do
    entries
    |> Enum.map(& &1.entries)
    |> List.flatten()
  end
end
