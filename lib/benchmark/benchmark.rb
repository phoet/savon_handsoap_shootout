module Shootout
  module Benchmark
    class SavonDynamic
      def self.run
        client = Savon::Client.new Shootout.endpoints[:bank_code][:uri]
        client.get_bank { |soap| soap.body = { "wsdl:blz" => "24050110" } }
      end
    end

    class SavonStatic
      def self.run
        client = Savon::Client.new Shootout.endpoints[:bank_code][:uri]
        client.get_bank! do |soap|
          soap.namespace = "http://thomas-bayer.com/blz/"
          soap.body = { "wsdl:blz" => "24050110" }
        end
      end
    end

    class Handsoap < Handsoap::Service
      endpoint Shootout.endpoints[:bank_code]

      def on_create_document(doc)
        doc.alias "tns", "http://thomas-bayer.com/blz/"
      end

      def on_response_document(doc)
        doc.add_namespace "ns1", "http://thomas-bayer.com/blz/"
      end

      def run
        invoke("tns:getBank") do |message|
          message.add "tns:blz", "24050110"
        end
      end
    end
  end
end
