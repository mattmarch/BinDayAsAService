defmodule BinDayAsAServiceWeb.PageController do
  use BinDayAsAServiceWeb, :controller
  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def postcode_search(conn, %{"postcode" => postcode}) do
    if PostcodeValidation.valid_ns_postcode?(postcode) do
      case postcode |> get_collection_dates_cached() do
        :postcode_not_found ->
          render(conn, "error.html", error_string: "Postcode not found")

        bin_details ->
          render(conn, "postcode_search.html", bin_details: bin_details)
      end
    else
      render(conn, "error.html", error_string: "Invalid postcode")
    end
  end

  defp get_collection_dates_cached(postcode) do
    case BinDayAsAService.Cache.get(BinDayAsAService.Cache, postcode, Date.utc_today()) do
      {:ok, bin_details} ->
        Logger.info("Cache hit for #{postcode}")
        bin_details

      :not_found ->
        Logger.info("Cache miss for #{postcode}")
        bin_details = CouncilBinsSite.get_collection_dates(postcode)

        BinDayAsAService.Cache.put(
          BinDayAsAService.Cache,
          postcode,
          Date.utc_today(),
          bin_details
        )

        bin_details
    end
  end
end
