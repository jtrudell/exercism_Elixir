defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  use Bitwise

  @actions %{1 => "wink", 2 => "double blink", 4 => "close your eyes", 8 => "jump"}

  def commands(code) do
   Enum.map(@actions, fn({num, action}) -> if add_action?(num, code) do action end end)
     |> Enum.filter(fn(action) -> action != nil end)
     |> reverse?((code &&& 16) == 16)
  end

  def add_action?(num, code) do
    (num &&& code) === num
  end

  def reverse?(ary, true) do
    Enum.reverse(ary)
  end

  def reverse?(ary, _) do
    ary
  end
end
