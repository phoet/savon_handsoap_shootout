module Shootout
  class Soap4rBankCode
    def self.zip_code(bank_code)
       driver = SOAP::WSDLDriverFactory.new(Shootout.endpoints[:bank_code][:uri]).create_rpc_driver
       result = driver.getBank("blz" => bank_code)
       result["details"]["plz"]
    end
  end
  
  class SavonBankCode
    def self.zip_code(bank_code)
      client = Savon::Client.new Shootout.endpoints[:bank_code][:uri]
      response = client.get_bank { |soap| soap.body = { "wsdl:blz" => bank_code } }
      response.to_hash[:get_bank_response][:details][:plz]
    end
  end

  class HandsoapBankCode < Handsoap::Service
    endpoint Shootout.endpoints[:bank_code]

    def on_create_document(doc)
      doc.alias "tns", "http://thomas-bayer.com/blz/"
    end

    def on_response_document(doc)
      doc.add_namespace "ns1", "http://thomas-bayer.com/blz/"
    end

    def zip_code(bank_code)
      response = invoke("tns:getBank") do |message|
        message.add "tns:blz", bank_code
      end
      (response/"//ns1:details/ns1:plz").first.to_s
    end
  end
end
