defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.codepoints(text)
    |> Enum.map(fn(letter) -> rotate_letter(letter, shift) end)
    |> List.to_string
  end

  def rotate_letter(letter, shift) do
    <<int::utf8>> = letter
    cond do
      shift >= 26 -> shift - 26
      :else -> shift
    end
    |> Kernel.+(int)
    |> encode(int, letter)
  end

  defp encode(code, int, letter) do
    cond do
      non_letter?(int) -> letter
      requires_wrap?(code, int) -> <<code-26::utf8>>
      :else -> <<code::utf8>>
    end
  end

  defp non_letter?(int), do: Enum.member?(32..64, int)
  defp requires_wrap?(code, int), do: (Enum.member?(65..90, int) && code > 90) || code > 122
end
