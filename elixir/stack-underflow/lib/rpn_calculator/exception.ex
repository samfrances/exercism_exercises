defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception [message: "division by zero occurred"]
  end

  # Please implement StackUnderflowError here.
  defmodule StackUnderflowError do
    @message "stack underflow occurred"

    defexception [message: @message]

    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        context -> %StackUnderflowError{message: "#{@message}, context: #{context}"}
      end
    end
  end

  def divide(stack) when length(stack) < 2 do
    raise StackUnderflowError, "when dividing"
  end
  def divide([0|_]) do
    raise DivisionByZeroError
  end
  def divide([a,b|_]) do
    div(b, a)
  end
end
