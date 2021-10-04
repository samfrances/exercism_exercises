defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {:ok, pid } = Task.start_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    status = receive do
      {:EXIT, _from = ^pid, _reason = :normal} -> :ok
      {:EXIT, _from = ^pid, _reason} -> :error
    after
      100 -> :timeout
    end
    Map.put(results, input, status)
  end

  def reliability_check(calculator, inputs) do
    previous_trap_exit = Process.flag(:trap_exit, true)
    try do
      inputs
        |> Enum.map(& start_reliability_check(calculator, &1))
        |> Enum.reduce(%{}, &await_reliability_check_result/2)
    after
      Process.flag(:trap_exit, previous_trap_exit)
    end
  end

  def correctness_check(calculator, inputs) do
    inputs
      |> Enum.map(& fn -> calculator.(&1) end)
      |> Enum.map(&Task.async/1)
      |> Enum.map(&Task.await(&1, 100))
  end
end
