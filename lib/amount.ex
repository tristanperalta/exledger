defmodule ExLedger.Amount do
  alias Decimal, as: D

  defstruct [:currency, number: D.new(0)]

  @type t :: %__MODULE__{
          number: integer(),
          currency: String.t()
        }

  def new({num, curr}), do: new(D.new(num), curr)
  def new(params), do: struct!(__MODULE__, params)
  def new(num, curr), do: new(%{number: D.new(num), currency: curr})

  def to_string(%__MODULE__{} = amount) do
    [D.to_string(amount.number), amount.currency]
    |> Enum.reject(&(&1 == nil))
    |> Enum.join(" ")
  end

  def eq?(%{currency: curr} = amount, %{currency: curr} = other_amount) do
    D.eq?(amount.number, other_amount.number)
  end

  def eq?(_, _), do: false

  def add(a, b), do: apply_op(:add, a, b)
  def sub(a, b), do: apply_op(:sub, a, b)
  def mult(a, b), do: apply_op(:mult, a, b)
  def div(a, b), do: apply_op(:div, a, b)

  defp apply_op(oper, %{currency: c} = a, %{currency: c} = b) do
    new(apply(D, oper, [a.number, b.number]), c)
  end

  defp apply_op(oper, _, _) do
    raise(ArithmeticError, "Unmatching currencies for #{oper} operation")
  end

  def zero(), do: new(0, nil)

  def negate(%__MODULE__{number: number} = amount) do
    %{amount | number: D.negate(number)}
  end
end
