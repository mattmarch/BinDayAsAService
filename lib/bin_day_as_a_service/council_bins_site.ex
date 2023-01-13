defmodule CouncilBinsSite do
  alias CouncilBinsSite.PageParsing
  alias CouncilBinsSite.Requests

  @base_url "https://forms.n-somerset.gov.uk"
  @collection_schedule_path "/Waste/CollectionSchedule"

  def get_collection_dates(postcode) do
    HTTPoison.start()
    collection_schedule_url = @base_url <> @collection_schedule_path
    cookies = Requests.get_cookies(collection_schedule_url)

    address_urpn =
      Requests.get_address_list_page(collection_schedule_url, cookies, postcode)
      |> PageParsing.first_address_option_from_page()

    result_path =
      Requests.get_address_submission_redirect(
        collection_schedule_url,
        cookies,
        postcode,
        address_urpn
      )

    Requests.get_result_page(@base_url <> result_path, cookies)
    |> PageParsing.parse_results_page()
  end
end
