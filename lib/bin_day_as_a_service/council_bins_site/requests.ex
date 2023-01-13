defmodule CouncilBinsSite.Requests do
  @form_content_type "application/x-www-form-urlencoded"

  def get_cookies(url) do
    HTTPoison.get!(url)
    |> find_header("Set-Cookie")
  end

  def get_address_list_page(url, cookies, postcode) do
    body = "PreviousHouse=&PreviousPostcode=&Postcode=#{postcode}"

    HTTPoison.post!(url, body, form_submit_headers(cookies))
    |> get_response_body()
  end

  def get_address_submission_redirect(url, cookies, postcode, urpn) do
    body = "PreviousHouse=&PreviousPostcode=#{postcode}&Postcode=#{postcode}&SelectedUprn=#{urpn}"

    HTTPoison.post!(url, body, form_submit_headers(cookies))
    |> find_header("Location")
  end

  def get_result_page(url, cookies) do
    headers = %{"Cookie" => cookies}

    HTTPoison.get!(url, headers)
    |> get_response_body()
  end

  defp find_header(%HTTPoison.Response{headers: headers}, name) do
    headers
    |> Enum.find(fn {header_name, _value} -> header_name == name end)
    |> elem(1)
  end

  defp get_response_body(%HTTPoison.Response{status_code: 200, body: body}), do: body

  defp form_submit_headers(cookies),
    do: %{"Cookie" => cookies, "Content-Type" => @form_content_type}
end
