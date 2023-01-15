defmodule CouncilBinsSite.PageParsing do
  alias CouncilBinsSite.CollectionDates

  def first_address_option_from_page(page) do
    {:ok, document} = Floki.parse_document(page)

    case document |> Floki.find("select#SelectedUprn") do
      [{"select", _select_node, address_options}] ->
        {"option", [{"value", first_urpn}], _address} = address_options |> hd()
        {:ok, first_urpn}

      _ ->
        :postcode_not_found
    end
  end

  def parse_results_page(page) do
    [{"table", _node, table_children}] =
      page
      |> Floki.parse_document!()
      |> Floki.find("table.table-striped")

    [{"thead", _head_styles, _head_children}, {"tbody", _body_styles, rows}] = table_children

    rows
    |> Enum.map(&parse_row/1)
  end

  defp parse_row({"tr", _attributes, items}) do
    [type, next_date, following_date] =
      items
      |> Enum.map(fn {"td", _attributes, [value]} -> value end)

    %CollectionDates{type: type, next: next_date, following: following_date}
  end
end
