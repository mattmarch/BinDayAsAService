defmodule CouncilBinsSite do
  alias CouncilBinsSite.PageParsing
  alias CouncilBinsSite.Requests

  @base_url "https://forms.n-somerset.gov.uk"
  @collection_schedule_path "/Waste/CollectionSchedule"

  def get_collection_dates(postcode) do
    schedule_url = @base_url <> @collection_schedule_path
    cookies = Requests.get_cookies(schedule_url)

    with {:ok, address_urpn} <- get_address_urpn(schedule_url, cookies, postcode),
         result_path <-
           Requests.get_address_submission_redirect(schedule_url, cookies, postcode, address_urpn),
         do: get_and_parse_results(@base_url <> result_path, cookies)
  end

  defp get_address_urpn(schedule_url, cookies, postcode) do
    Requests.get_address_list_page(schedule_url, cookies, postcode)
    |> PageParsing.first_address_option_from_page()
  end

  defp get_and_parse_results(url, cookies) do
    Requests.get_result_page(url, cookies)
    |> PageParsing.parse_results_page()
  end
end
