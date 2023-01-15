defmodule BinDayAsAServiceWeb.PageControllerTest do
  use BinDayAsAServiceWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Bin Day As A Service"
  end
end
