require "uri"
require "net/http"

begin
  require "colorize"
rescue LoadError
  puts "Install the 'colorize' gem for colorized shell output."
end

module Shootout

  @endpoint_error = "Unfortunately not all endpoints seem to be available!"

  @endpoints = {
    :bank_code => { :uri => "http://www.thomas-bayer.com/axis2/services/BLZService?wsdl", :version => 1 },
    :currency  => { :uri => "http://www.webservicex.net/CurrencyConvertor.asmx?WSDL",     :version => 2 },
    :iban      => { :uri => "http://www.unifiedsoftware.co.uk/freeibanvalidate.wsdl",     :version => 1 }
  }

  def self.endpoints
    @endpoints
  end

  def self.validate_endpoints!
    return if @endpoints.all? { |name, details| endpoint_available? details[:uri] }
    puts @endpoint_error.red rescue puts @endpoint_error
    exit
  end

private

  def self.endpoint_available?(endpoint)
    case Net::HTTP.get_response URI.parse(endpoint)
      when Net::HTTPSuccess then true
      else false
    end
  rescue
    false
  end

end
