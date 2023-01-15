defmodule BinDayAsAServiceWeb.PageController do
  use BinDayAsAServiceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def postcode_search(conn, %{"postcode" => postcode}) do
    bin_details =
      postcode
      |> CouncilBinsSite.get_collection_dates()
      |> inspect()

    render(conn, "postcode_search.html", bin_detail_string: bin_details)
  end
end
