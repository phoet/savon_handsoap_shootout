# soap-libraries
require "savon"
require "handsoap"
require "soap/rpc/driver"
require "soap/wsdlDriver"
require "nokogiri"

# stuff for endpoint-checks
require "uri"
require "net/http"


# Disable logging
Savon::Request.log = false
#Handsoap::Service.logger = $stdout
Handsoap.http_driver = :httpclient

require "shootout/shootout"
require "shootout/bank_code"
require "shootout/iban"
require "benchmark/benchmark"
