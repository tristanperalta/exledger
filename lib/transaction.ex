defmodule ExLedger.Transaction do
  defstruct [:id, :description, :date, :status, postings: [], balances: %{}]

  @type t :: %__MODULE__{
          date: DateTime.t(),
          status: any(),
          description: String.t(),
          balances: map(),
          postings: [Posting.t()]
        }

  def new(), do: new(%{})
  def new(desc) when is_binary(desc), do: new(%{description: desc})

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  def add_entry(txn, account, amount) do
    add_entry(txn, %ExLedger.Posting{account: account, amount: amount})
  end

  def add_entry(%{postings: postings} = txn, %ExLedger.Posting{amount: amount} = posting) do
    txn
    |> Map.put(:entries, [posting | postings])
    |> compute_balance(amount)
  end

  def compute_balance(txn, amount) do
    Map.put(txn, :balances, update_balance(txn.balances, amount))
  end

  defp update_balance(balances, {qty, curr}) do
    Map.update(balances, curr, qty, fn e -> e + qty end)
  end

  def balanced?(%{balances: balances}) do
    balances
    |> Map.values()
    |> Enum.all?(&(&1 == 0))
  end
end
