module Shootout

  @endpoints = {
    :bank_code => { :uri => "http://www.thomas-bayer.com/axis2/services/BLZService?wsdl", :version => 1 },
    :iban      => { :uri => "http://www.unifiedsoftware.co.uk/freeibanvalidate.wsdl",     :version => 1 }
  }

  def self.endpoints
    @endpoints
  end

  def self.endpoint_available?(endpoint)
    case Net::HTTP.get_response URI.parse(endpoint)
      when Net::HTTPSuccess then true
      else false
    end
  rescue
    false
  end

end
