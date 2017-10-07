defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    if rem(String.length(rna), 3) != 0, do: {:error, "invalid RNA"}
    ary_builder(rna)
  end

  def ary_builder(rna) do
    first = section(rna, 0, 2)
    middle = section(rna, 3, 5)
    last = section(rna, 6, 8)

    result = cond do
      List.first(first) === "invalid codon" -> "invalid codon"
      List.first(last) === "STOP" -> first ++ middle
      true  -> first ++ middle ++ last
    end
    result |> rna_result
  end

  def section(rna, start, stop) do
    [elem(of_codon(String.slice(rna, start..stop)), 1)]
  end

  def rna_result("invalid codon") do
    { :error, "invalid RNA" }
  end

  def rna_result(rna_ary) do
    codon_result(rna_ary)
  end

  def codon_result("invalid codon") do
    { :error, "invalid codon" }
  end

  def codon_result(rna_ary) do
    { :ok, rna_ary }
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case codon do
      "AUG" -> "Methionine"
      "UUU" -> "Phenylalanine"
      "UUC" -> "Phenylalanine"
      "UUA" -> "Leucine"
      "UUG" -> "Leucine"
      "UCU" -> "Serine"
      "UCC" -> "Serine"
      "UCA" -> "Serine"
      "UCG" -> "Serine"
      "UAU" -> "Tyrosine"
      "UAC" -> "Tyrosine"
      "UGU" -> "Cysteine"
      "UGC" -> "Cysteine"
      "UGG" -> "Tryptophan"
      "UAA" -> "STOP"
      "UAG" -> "STOP"
      "UGA" -> "STOP"
      _ -> "invalid codon"
    end
    |> codon_result
  end
end

