defmodule BinDayAsAServiceWeb.PageController do
  use BinDayAsAServiceWeb, :controller

  def index(conn, _params) do
    bin_details =
      "postcode here"
      |> CouncilBinsSite.get_collection_dates()
      |> inspect()

    render(conn, "index.html", bin_detail_string: bin_details)
  end
end
