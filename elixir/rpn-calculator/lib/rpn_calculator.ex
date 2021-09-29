defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      _e -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      e -> {:error, e.message}
    end
  end
end
