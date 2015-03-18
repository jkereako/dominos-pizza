require 'optparse'
require 'ostruct'

module DominosPizza
  class CLI

    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.encoding = "utf8"
      options.verbose = false

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: dominos-pizza [options]"

        opts.separator ""
        opts.separator "Required arguments:"

        # Required: street name
        opts.on("-s", "--street STREET", "Your street name") do |street|
          options.street = street
        end

        # Required: zip code
        opts.on("-z", "--zip ZIP CODE", "Your zip code") do |zip|
          options.zip = zip
        end

        opts.separator ""
        opts.separator "Common options:"

        # Boolean switch.
        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options.verbose = v
        end

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
      options
    end  # parse()

  end  # class OptparseExample
end
