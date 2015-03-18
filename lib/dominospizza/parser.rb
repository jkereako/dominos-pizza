require "json"

module DominosPizza
  module Parser
    module_function

    # Convert the JSON data string into an object and filter out useless data
    def parse_store_data(json:)
      store_data = JSON.parse(json)

      stores = Array.new
      store_data["Stores"].each do |store|
        filtered_data = store.select do |key, value|
          ["StoreID", "Phone", "AddressDescription", "ServiceHoursDescription"].include?(key)
        end
        stores.push(filtered_data)
      end

      stores
    end
  end
end
