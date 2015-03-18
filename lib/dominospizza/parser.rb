require "json"

module DominosPizza
  module Parser
    module_function

    # Convert the JSON data string into an object and filter out useless data
    def parse_store_data(json:)
      store_data = JSON.parse(json)

      stores = Array.new
      store_data["Stores"].each do |store|
        # Filter the object leaving only the keys we require
        filtered_data = store.select do |key, value|
          ["StoreID", "Phone", "AddressDescription", "ServiceHoursDescription"].include?(key)
        end

        # Rename the keys so they are all ready to print to stdout
        mappings = {"StoreID" => "Store #",
                    "Phone" => "Phone",
                    "AddressDescription" => "Location",
                    "ServiceHoursDescription" =>"Hours"}

        stores.push(Hash[filtered_data.map {|k, v| [mappings[k], v] }])
      end

      stores
    end
  end
end
