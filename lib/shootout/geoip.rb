module Shootout
  class Soap4rGeoIP
    def self.geo_ip(ip)
       driver = SOAP::WSDLDriverFactory.new(Shootout.endpoints[:geoip][:uri]).create_rpc_driver
       result = driver.GetGeoIP("IPAddress" => ip)
       result.getGeoIPResult.countryName
    end
  end
  
  class SavonGeoIP
    def self.geo_ip(ip)
      client = Savon::Client.new do |wsdl|
        wsdl.document = Shootout.endpoints[:geoip][:uri]
      end
      
      response = client.request :web, :get_geo_ip do |soap|
        soap.namespaces["xmlns:web"] = Shootout.endpoints[:geoip][:namespace]
        soap.body = { 'web:IPAddress' => ip }
      end
      
      response.to_hash[:get_geo_ip_response][:get_geo_ip_result][:country_name]
    end
  end
  
  class HandsoapGeoIP < Handsoap::Service
    endpoint Shootout.endpoints[:geoip]
  
    def on_create_document(doc)
      doc.alias "web",  Shootout.endpoints[:geoip][:namespace]
    end
  
    def on_response_document(doc)
      doc.add_namespace "ns1",  Shootout.endpoints[:geoip][:namespace]
    end
  
    def geo_ip(ip)
      response = invoke("web:GetGeoIP") do |message|
        message.add "web:IPAddress", ip
      end
      (response/"//ns1:GetGeoIPResult/ns1:CountryName").first.to_s
    end
  end
end
