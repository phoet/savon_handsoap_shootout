$:.unshift File.join(File.dirname(__FILE__), "lib")

require "spec/rake/spectask"
require "shootout"
require "logger"

include FileUtils

LOGGER = Logger.new(STDOUT)

def info(message)
  LOGGER.info message
end

task :default => :spec
task :spec => :validate_endpoints

# configure rspec
Spec::Rake::SpecTask.new do |spec|
  spec.spec_files = FileList["spec/**/*_spec.rb"]
  spec.spec_opts << "--color"
  spec.libs += ["lib", "spec"]
end

desc "Validate SOAP endpoints"
task :validate_endpoints do
  info "validating soap endpoints"
  Shootout.validate_endpoints!
end

desc "Perform a benchmark test"
task :benchmark do
  info "performing a benchmark test"
  require "benchmark"
  xml_parsers = [:rexml, :nokogiri, :libxml]
  http_drivers = [:curb, :httpclient, :net_http] # :event_machine, seems not to work properly

  Benchmark.bm(30) do |x|
    x.report("savon dynamic") do
      25.times { Shootout::Benchmark::SavonDynamic.run }
    end
    x.report("savon static") do
      25.times { Shootout::Benchmark::SavonStatic.run }
    end
    xml_parsers.each do |parser|
      http_drivers.each do |driver|
        x.report("handsoap #{driver} #{parser}") do
          Handsoap.http_driver = driver
          Handsoap.xml_query_driver = parser
          25.times { Shootout::Benchmark::Handsoap.run }
        end 
      end
    end
  end
end

desc "Perform a JRuby benchmark test"
task :benchmark_jruby do
  info "performing a JRuby benchmark test"
  info "should be perfomed with jruby"
  require "benchmark"
  Benchmark.bm(30) do |x|
    x.report("savon jruby dynamic") do
      25.times { Shootout::Benchmark::SavonDynamic.run }
    end
    x.report("savon jruby static") do
      25.times { Shootout::Benchmark::SavonStatic.run }
    end
    x.report("handsoap jruby") do
      Handsoap.http_driver = :net_http
      Handsoap.xml_query_driver = :rexml
      25.times { Shootout::Benchmark::Handsoap.run }
    end
  end
end
