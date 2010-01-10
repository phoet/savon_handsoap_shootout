module Shootout
  class SavonIBAN
    def self.validate(iban)
      client = Savon::Client.new Shootout.endpoints[:iban][:uri]
      response = client.ibanvalidate do |soap|
        soap.namespace = "urn:freeservices"
        soap.body = { :params => iban }
      end
      response.to_hash[:ibanvalidate_response][:validate_result]
    end
  end

  class HandsoapIBAN < Handsoap::Service
    endpoint :uri => "https://www.unifiedsoftware.co.uk/cgi-bin/freeservicedispatcher.cgi", :version => 1

    def on_create_document(doc)
      doc.alias "urn", "urn:freeservices"
    end

    def on_response_document(doc)
      doc.add_namespace "ns1", "urn:freeservices"
    end

    def validate(iban)
      response = invoke("urn:ibanvalidate", :soap_action => "urn:freeservices#ibanvalidate") do |message|
        message.add "params", iban
      end
      (response/"//ns1:ValidateResult").first.to_s
    end
  end
end
