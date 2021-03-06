module Shootout

  @endpoints = {
    :bank_code => { 
      :uri => "http://www.thomas-bayer.com/axis2/services/BLZService?wsdl", 
      :version => 1,
      :namespace => "http://thomas-bayer.com/blz/",
    },
    :iban => { 
      :uri => "http://www.unifiedsoftware.co.uk/freeibanvalidate.wsdl",
      :version => 1,
      :namespace => "urn:freeservices",
    },
    :bushism => {
      :uri => "http://greg.froh.ca/fun/random_bushism/soap/index.php?wsdl",
      :version => 1,
      :namespace => "urn:RandomBushism"
    },
    :geoip => {
      :uri => "http://www.webservicex.net/geoipservice.asmx?wsdl",
      :version => 2,
      :namespace => "http://www.webservicex.net/"
    }
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
