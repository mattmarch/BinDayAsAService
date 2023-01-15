defmodule PostcodeValidation do
  @valid_outward_codes [
    "BS8",
    "BS20",
    "BS21",
    "BS22",
    "BS23",
    "BS24",
    "BS25",
    "BS26",
    "BS29",
    "BS41",
    "BS48",
    "BS49"
  ]

  @doc ~S"""
  Validates a that a postcode is a valid North Somerset postcode.
  iex> PostcodeValidation.valid_ns_postcode?("BS20+1AA")
  true
  iex> PostcodeValidation.valid_ns_postcode?("BS20+31AA")
  false
  iex> PostcodeValidation.valid_ns_postcode?("BS1+1AA")
  false
  iex> PostcodeValidation.valid_ns_postcode?("B20+1AA")
  false
  iex> PostcodeValidation.valid_ns_postcode?("BS20+AA2")
  false
  iex> PostcodeValidation.valid_ns_postcode?("BS8+9BB")
  true
  """
  def valid_ns_postcode?(postcode) do
    postcode
    |> String.upcase()
    |> String.split("+")
    |> valid_split_postcode?()
  end

  defp valid_split_postcode?([outward_code, inward_code]) do
    valid_outward_code?(outward_code) and valid_inward_code?(inward_code)
  end

  defp valid_split_postcode?(_), do: false

  defp valid_outward_code?(outward_code), do: @valid_outward_codes |> Enum.member?(outward_code)

  defp valid_inward_code?(inward_code) do
    String.length(inward_code) == 3 and String.match?(inward_code, ~r/[0-9][A-Z][A-Z]/)
  end
end
