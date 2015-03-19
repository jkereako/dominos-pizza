require "optparse"
require "ostruct"
require "pp"

module DominosPizza
  class CLI

    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.encoding = "utf8"
      options.verbose = false

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: dominospizza [-s zip street][-m store]"

        opts.on("-f", '--find [ZIP, "STREET NAME"]', Array, "Search for the store nearest to the zip code and street name" ) do|list|
          data = DominosPizza::WebService.get_stores(zip:list[0], street:list[1])

          DominosPizza::Parser.parse_store_data(json:data).each do |store|
            store.each do |key, value|
              puts "  #{key}: #{value}"
            end
            puts "  ----------------------------------------"
          end

          options[:list] = list
        end

        # see: http://jsoneditoronline.org/?id=537c9b3612cc2422fe6021228c9d564b
        opts.on("-s", "--store STORE_ID", "View the info of a particular store") do |store_id|
          data = DominosPizza::WebService.get_store(store_id:store_id)
          puts data
          options.store_id = store_id
        end

        # see: http://jsoneditoronline.org/?id=05da63256a05b15598039b1f79bc08fa
        opts.on("-m", "--menu STORE_ID", "View the menu of a particular store") do |store_id|
          data = DominosPizza::WebService.get_store_menu(store_id:store_id)
          puts data
          options.store_id = store_id
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts DominosPizza::VERSION.dup
        end
      end

      opt_parser.parse!(args)

    end  # parse()

  end  # class OptparseExample
end
