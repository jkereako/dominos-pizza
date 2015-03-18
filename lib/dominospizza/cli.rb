require 'optparse'
# require 'ostruct'

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

        opts.on("-s", '--search [ZIP, "STREET NAME"]', Array, "Search for the store nearest to the zip code and street name" ) do|list|
          puts DominosPizza::WebService.download_store_data(zip:list[0], street:list[1])
          options[:list] = list
        end

        # Required: zip code
        opts.on("-m", "--menu STORE_ID", "View the menu of a particular store") do |zip|
          options.zip = zip
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
