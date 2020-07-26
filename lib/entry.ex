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
    |> Enum.map(&(&1.transactions))
    |> List.flatten()
  end
end
