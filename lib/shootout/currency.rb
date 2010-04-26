module Shootout
  class Soap4rCurrency
    def self.conversion_rate(from, to)
       driver = SOAP::WSDLDriverFactory.new(Shootout.endpoints[:currency][:uri]).create_rpc_driver
       result = driver.ConversionRate("FromCurrency" => from, "ToCurrency" => to)
       result["ConversionRateResult"]
    end
  end
  
  class SavonCurrency
    def self.conversion_rate(from, to)
      client = Savon::Client.new Shootout.endpoints[:currency][:uri]
      response = client.conversion_rate do |soap|
        soap.version = 2
        soap.body = { "wsdl:FromCurrency" => from, "wsdl:ToCurrency" => to }
      end
      response.to_hash[:conversion_rate_response][:conversion_rate_result]
    end
  end

  class HandsoapCurrency < Handsoap::Service
    endpoint Shootout.endpoints[:currency]

    def on_create_document(doc)
      doc.alias "tns", "http://www.webserviceX.NET/"
    end

    def on_response_document(doc)
      doc.add_namespace "ns1", "http://www.webserviceX.NET/"
    end

    def conversion_rate(from, to)
      response = invoke("tns:ConversionRate") do |message|
        message.add "tns:FromCurrency", from
        message.add "tns:ToCurrency", to
      end
      (response/"//ns1:ConversionRateResult").first.to_s
    end
  end
end
