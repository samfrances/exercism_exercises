defmodule TakeANumber do
  def start() do
    spawn(&run/0)
  end

  defp run(state \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        run(state)
      {:take_a_number, sender_pid} ->
        new_state = state + 1
        send(sender_pid, new_state)
        run(new_state)
      :stop -> nil
      _ -> run(state)
    end

  end
end
