require "net/http"

module DominosPizza
  module WebService
    module_function

    API_URL = "https://order.dominos.com/power/"
    PIZZA_TRACKER_URL = "https://trkweb.dominos.com/orderstorage/GetTrackerData?"

    attr_reader :uri

    def get_stores(street:, zip:)
      uri = URI(API_URL + "store-locator")
      uri.query = URI.encode_www_form({:s => street, :c => zip})

      response = Net::HTTP.get_response(uri)

      response.body if response.is_a?(Net::HTTPSuccess)
    end

    def get_store(store_id:)
      uri = URI(API_URL + "store/#{store_id}/profile")

      response = Net::HTTP.get_response(uri)
      response.body if response.is_a?(Net::HTTPSuccess)
    end

    # This downloads an eff-load of data
    def get_store_menu(store_id:)
      uri = URI(API_URL + "store/#{store_id}/menu")
      uri.query = URI.encode_www_form({:lang => "en", :structured => true})

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
