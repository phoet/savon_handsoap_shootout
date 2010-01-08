$:.unshift File.join(File.dirname(__FILE__), "lib")

require "spec/rake/spectask"
require "shootout"
require 'logger'

include FileUtils

LOGGER = Logger.new(STDOUT)
gems = {'savon' => '0.6.7', 'handsoap' => '1.1.4', 'RedCloth' => '4.2.2'}

def info(message)
  LOGGER.info message
end

task :default => :spec
task :spec => :install_gems
task :spec => :validate_endpoints

desc 'installs all the gems'
task :install_gems do
  gems.each do |k, v|
    info "checking availability of #{k} in version #{v}"
    if Gem.cache.find_name(k, "=#{v}").empty? 
      info "gem not found, installing #{k} #{v}"
      info `gem install -v=#{v} #{k}`
    end
    require k
  end
end

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

desc "Perform a benchmark-test"
task :benchmark do
  info "performing a benchmark-test"
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
