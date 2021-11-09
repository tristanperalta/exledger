defmodule ExLedger.Entry do
  defstruct ~w[account amount]a

  alias ExLedger.{Account, Amount}

  @type t :: %__MODULE__{
          account: Account.t(),
          amount: Amount.t()
        }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end

  def new(account, {qty, currency}) do
    new(%{account: account, amount: Amount.new(qty, currency)})
  end
end
