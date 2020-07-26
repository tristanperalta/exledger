defmodule ExLedger.Amount do

  defstruct ~w[quantity currency]a

  @type t :: %__MODULE__{
    quantity: integer(),
    currency: tuple() | String.t()
  }

  def new(attrs) do
    struct!(%__MODULE__{}, attrs)
  end
end
