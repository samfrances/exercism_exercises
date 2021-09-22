defmodule LibraryFees do

  @monday 1
  @monday_discount 0.5

  @spec datetime_from_string(binary) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @spec before_noon?(NaiveDateTime.t) :: boolean
  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00])
    |> Kernel.==(:lt)
  end

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days_to_return checkout_datetime)
  end

  defp days_to_return(datetime) do
    if before_noon?(datetime), do: 28, else: 29
  end

  @spec days_late(Date.t, NaiveDateTime.t) :: non_neg_integer
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  @spec monday?(NaiveDateTime.t) :: boolean
  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(@monday)
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_dt = NaiveDateTime.from_iso8601!(checkout)
    returned_dt = NaiveDateTime.from_iso8601!(return)
    planned_return_date = return_date(checkout_dt)
    days_late = days_late(planned_return_date, returned_dt)
    fee = days_late * rate
    if monday?(returned_dt) do
      fee - round(@monday_discount * fee)
    else
      fee
    end
  end

end
