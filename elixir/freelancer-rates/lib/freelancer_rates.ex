defmodule FreelancerRates do
  @billable_hours_in_day 8
  @billable_days_in_month 22

  @spec daily_rate(number) :: float
  def daily_rate(hourly_rate) do
    (@billable_hours_in_day * hourly_rate) / 1
  end
  @spec daily_rate(number, number) :: float
  def daily_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> apply_discount(discount)
  end

  @spec apply_discount(number, number) :: float
  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * (discount / 100))
  end

  @spec monthly_rate(number, number) :: integer
  def monthly_rate(hourly_rate, discount) do
    @billable_days_in_month * daily_rate(hourly_rate, discount)
    |> Float.ceil()
    |> trunc()
  end

  @spec days_in_budget(number, number, number) :: float
  def days_in_budget(budget, hourly_rate, discount) do
    budget / daily_rate(hourly_rate, discount)
    |> Float.floor(1)
  end

end
