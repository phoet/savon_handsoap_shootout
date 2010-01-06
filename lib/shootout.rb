require "savon"
require "handsoap"

# Additional Handsoap dependencies
require "curb"
require "nokogiri"

# Disable logging
Savon::Request.log = false
#Handsoap::Service.logger = $stdout

require "shootout/shootout"
require "shootout/bank_code"
require "shootout/currency"
require "shootout/iban"
require "benchmark/benchmark"