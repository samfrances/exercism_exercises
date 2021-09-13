defmodule GuessingGame do

  def compare(secret_number, guess \\ :no_guess)
  def compare(x, x), do: "Correct"
  def compare(_secret, :no_guess), do: "Make a guess"

  def compare(secret_number, guess) when
    abs(secret_number - guess) == 1
  do
    "So close"
  end

  def compare(secret_number, guess) when
    secret_number < guess
  do
    "Too high"
  end

  def compare(_secret, _guess), do: "Too low"

end
