defmodule Secrets do
  @spec secret_add(number) :: (number -> number)
  def secret_add(secret) do
    &(&1 + secret)
  end

  @spec secret_subtract(number) :: (number -> number)
  def secret_subtract(secret) do
    &(&1 - secret)
  end

  @spec secret_multiply(number) :: (number -> number)
  def secret_multiply(secret) do
    &(&1 * secret)
  end

  @spec secret_divide(integer) :: (integer -> integer)
  def secret_divide(secret) do
    &(div &1, secret)
  end

  @spec secret_and(integer) :: (integer -> integer)
  def secret_and(secret) do
    fn x -> Bitwise.&&&(secret, x) end
  end

  @spec secret_xor(integer) :: (integer -> integer)
  def secret_xor(secret) do
    fn x -> Bitwise.^^^(secret, x) end
  end

  @spec secret_combine((any -> any), (any -> any)) :: (any -> any)
  def secret_combine(secret_function1, secret_function2) do
    fn x -> x |> secret_function1.() |> secret_function2.() end
  end
end
