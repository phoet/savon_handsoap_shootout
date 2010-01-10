# common
require "colorize"

# soap-libraries
require "savon"
require "handsoap"

# additional handsoap dependencies
#require "curb"
#require "nokogiri"

# stuff for endpoint-checks
require "uri"
require "net/http"


# Disable logging
Savon::Request.log = false
#Handsoap::Service.logger = $stdout

require "shootout/shootout"
require "shootout/bank_code"
require "shootout/currency"
require "shootout/iban"
require "benchmark/benchmark"