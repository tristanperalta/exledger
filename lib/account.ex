defmodule ExLedger.Account do

  defstruct ~w[name sub_accounts]a

  @type t :: %__MODULE__{
    name: String.t(),
    sub_accounts: [__MODULE__.t()]
  }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end
end
