module Shootout
  class Soap4rIBAN
    def self.validate(iban)
      driver = SOAP::WSDLDriverFactory.new(Shootout.endpoints[:iban][:uri]).create_rpc_driver
      driver.ibanvalidate(iban)
    end
  end

  class SavonIBAN
    def self.validate(iban)
      client = Savon::Client.new do
        wsdl.document = Shootout.endpoints[:iban][:uri]
      end
      
      response = client.request :urn, :ibanvalidate do |soap|
        soap.namespaces["xmlns:urn"] = Shootout.endpoints[:iban][:namespace]
        soap.body = { :params => iban }
      end

      response.to_hash[:ibanvalidate_response][:validate_result]
    end
  end

  class HandsoapIBAN < Handsoap::Service
    endpoint :uri => "https://www.unifiedsoftware.co.uk/cgi-bin/freeservicedispatcher.cgi", :version => 1

    def on_create_document(doc)
      doc.alias "urn", Shootout.endpoints[:iban][:namespace]
    end

    def on_response_document(doc)
      doc.add_namespace "ns1", Shootout.endpoints[:iban][:namespace]
    end

    def validate(iban)
      response = invoke("urn:ibanvalidate", :soap_action => "urn:freeservices#ibanvalidate") do |message|
        message.add "params", iban
      end
      (response/"//ns1:ValidateResult").first.to_s
    end
  end
end
