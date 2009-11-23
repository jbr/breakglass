require 'optparse'
require 'ostruct'

module Clickatell
  module Utility
    class Options #:nodoc:
      class << self
        
        def parse(args)
          @options = self.default_options
          parser = OptionParser.new do |opts|
            opts.banner = "Usage: sms [options] recipient(s) message"
            opts.separator "  Recipients can be a comma-separated list, up to 100 max."
            opts.separator ""
            opts.separator "Specific options:"
          
            opts.on('-u', '--username USERNAME',
              "Specify the clickatell username (overrides ~/.clickatell setting)") do |username|
               @options.username = username 
            end
          
            opts.on('-p', '--password PASSWORD',
              "Specify the clickatell password (overrides ~/.clickatell setting)") do |password|
               @options.password = password
            end
          
            opts.on('-k', '--apikey API_KEY',
              "Specify the clickatell API key (overrides ~/.clickatell setting)") do |key|
               @options.api_key = key
            end
            
            opts.on('-f', '--from NAME_OR_NUMBER',
              "Specify the name or number that the SMS will appear from") do |from|
               @options.from = from 
            end
          
            opts.on('-b', '--show-balance',
               "Shows the total number of credits remaining on your account") do
               @options.show_balance = true
            end
          
            opts.on('-s', '--status MESSAGE_ID',
               "Displays the status of the specified message.") do |message_id|
               @options.message_id = message_id
               @options.show_status = true  
            end
            
            opts.on('-S', '--secure',
                "Sends request using HTTPS") do
                Clickatell::API.secure_mode = true
              end
            
            opts.on('-d', '--debug') do
               Clickatell::API.debug_mode = true
            end
          
            opts.on_tail('-h', '--help', "Show this message") do
              puts opts
              exit
            end
          
            opts.on_tail('-v', '--version') do
              puts "Ruby Clickatell SMS Utility #{Clickatell::VERSION}"
              exit
            end
          end
        
          parser.parse!(args)
          @options.recipient = ARGV[-2]
          @options.message   = ARGV[-1]
        
          if (@options.message.nil? || @options.recipient.nil?) && send_message?
            puts "You must specify a recipient and message!"
            puts parser
            exit
          end
          
          @options.recipient = @options.recipient.split(",")

          return @options
        
        rescue OptionParser::MissingArgument => e
          switch_given = e.message.split(':').last.strip
          puts "The #{switch_given} option requires an argument."
          puts parser
          exit
        end
      
        def default_options
          options = OpenStruct.new
          config_file = File.open(File.join(ENV['HOME'], '.clickatell'))
          config = YAML.load(config_file)
          options.username = config['username']
          options.password = config['password']
          options.api_key  = config['api_key']
          options.from     = config['from']
          return options
        rescue Errno::ENOENT
          return options
        end
        
        def send_message?
          (@options.show_status.nil? &&
           @options.show_balance.nil?)
        end
        
      end
    end
  end
end
