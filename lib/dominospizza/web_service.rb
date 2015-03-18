module DominosPizza
  module WebService
    API_URL = "https://order.dominos.com/power/"
    PIZZA_TRACKER_URL = "https://trkweb.dominos.com/orderstorage/GetTrackerData?"

    attr_reader :uri

    def download_store_data(street, zip)
      uri = URI(API_URL)
      uri.query = URI.encode_www_form({:s => street, :c => zip})

      response = Net::HTTP.get_response(uri)

      response.body if response.is_a?(Net::HTTPSuccess)
    end

    def download_store_menu(store_id)
      uri = URI(API_URL + "store#{store_id}/menu")
      uri.query = URI.encode_www_form({:lang => "en", :structured => True})

      response = Net::HTTP.get_response(uri)

      response.body if response.is_a?(Net::HTTPSuccess)
    end

    def validate_order
      uri = URI(API_URL + "validate-order")
    end

    def price_order
      uri = URI(API_URL + "price-order")
    end

    def place_order
      uri = URI(API_URL + "place-order")
    end

  end
end
