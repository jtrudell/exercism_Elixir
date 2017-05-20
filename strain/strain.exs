defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    keep([], list, fun)
  end

  def keep(new_list, list, fun) when list != [] do
    [item | tail] = list
    if(fun.(item), do: [item | new_list], else: new_list)
      |> keep(tail, fun)
  end

  def keep(new_list, [], _fun) do
    Enum.reverse(new_list)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    list -- keep(list, fun)
  end
end
