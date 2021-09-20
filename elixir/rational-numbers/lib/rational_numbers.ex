defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @spec new(integer, integer) :: rational
  def new(a, b) do
    reduce({a, b})
  end

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    new(
      (a1 * b2) + (a2 * b1),
      b1 * b2
    )
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    add({a1, b1}, {-a2, b2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    new(
      a1 * a2,
      b1 * b2
    )
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    multiply({a1, b1}, {b2, a2})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    new(
      Kernel.abs(a),
      Kernel.abs(b)
    )
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(r, n) when n < 0, do: pow_rational(r, Kernel.abs(n))
  def pow_rational({a, b}, n) do
    new(
      Integer.pow(a, n),
      Integer.pow(b, n)
    )
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    :math.pow(x, (a / b))
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) do
    the_gcd = gcd(a, b)
    {div(a, the_gcd), div(b, the_gcd)}
    |> simplify_negative()
  end

  defp simplify_negative({a, b}) when a < 0 and b < 0 do
    {Kernel.abs(a), Kernel.abs(b)}
  end
  defp simplify_negative({a, b}) when a >= 0 and b < 0 do
    {-a, Kernel.abs(b)}
  end
  defp simplify_negative(rational), do: rational

  @doc """
  Calculates greatest common divisor by
  Euclidean algorithm
  """
  def gcd(0, b), do: b
  def gcd(a, 0), do: a
  def gcd(a, b) do
    gcd(b, rem(a, b))
  end

end
