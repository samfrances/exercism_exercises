defmodule HighSchoolSweetheart do

  @template """
       ******       ******
     **      **   **      **
   **         ** **         **
  **            *            **
  **                         **
  **     X. X.  +  Y. Y.     **
   **                       **
     **                   **
       **               **
         **           **
           **       **
             **   **
               ***
                *
  """

  @spec first_letter(binary) :: nil | binary
  def first_letter(name) when
    is_binary(name)
    and byte_size(name) > 0
  do
    name
    |> String.trim()
    |> String.first()
  end

  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Operator.concat(".")
  end

  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    @template
    |> String.replace("X. X.",  initials(full_name1))
    |> String.replace("Y. Y.",  initials(full_name2))
  end
end

defmodule Operator do
  def concat(a, b), do: a <> b
end
