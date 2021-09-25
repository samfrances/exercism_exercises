defmodule Newsletter do
  def read_emails(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.binwrite(pid, "#{email}\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    logpid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(logpid, email)
        _ -> nil
      end
    end)

    close_log(logpid)
  end
end
