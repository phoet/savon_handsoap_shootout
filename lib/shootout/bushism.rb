module Shootout
  class Soap4rBushism
    def self.bushism
      driver = SOAP::WSDLDriverFactory.new(Shootout.endpoints[:bushism][:uri]).create_rpc_driver
      response = driver.getRandomBushism
      return response.bushism, response.context
    end
  end

  class SavonBushism
    def self.bushism
      client = Savon::Client.new do
        wsdl.document = Shootout.endpoints[:bushism][:uri]
      end
      
      response = client.request :urn, :get_random_bushism
      part = response.to_hash[:get_random_bushism_response][:random_bushism]
      return part[:bushism], part[:context]
    end
  end

  class HandsoapBushism < Handsoap::Service
    endpoint Shootout.endpoints[:bushism]
  
    def on_create_document(doc)
      doc.alias "urn", Shootout.endpoints[:bushism][:namespace]
    end
  
    def on_response_document(doc)
      doc.add_namespace "ns1", Shootout.endpoints[:bushism][:namespace]
    end
  
    def bushism
      response = invoke("urn:getRandomBushism", :soap_action => "getRandomBushism")
      return (response/"//RandomBushism/bushism").first.to_s, (response/"//RandomBushism/context").first.to_s
    end
  end
end
