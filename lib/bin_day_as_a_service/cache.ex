defmodule BinDayAsAService.Cache do
  use Agent

  @doc """
  Starts a new cache.
  """
  def start_link(opts) do
    Agent.start_link(fn -> %{} end, opts)
  end

  @doc """
  Gets a value from the cache by postcode if the date matches
  """
  def get(cache, postcode, date) do
    case Agent.get(cache, &Map.get(&1, postcode)) do
      %CacheEntry{date: ^date, value: value} -> {:ok, value}
      _ -> :not_found
    end
  end

  @doc """
  Puts the value in the cache under postcode with the given date
  """
  def put(cache, postcode, date, value) do
    Agent.update(cache, &Map.put(&1, postcode, %CacheEntry{value: value, date: date}))
  end
end
