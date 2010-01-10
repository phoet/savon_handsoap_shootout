require 'logger'

LOGGER = Logger.new(STDOUT)
gems = {  'rake'        => '0.8.7', 
          'rspec'       => '1.2.9',
          'colorize'    => '0.5.8', 
          'savon'       => '0.7.1', 
          'handsoap'    => '1.1.4',
          'curb'        => '0.6.2.1',
          'libxml-ruby' => '1.1.3', # nokogiri needs a new version of libxml
          'nokogiri'    => '1.4.1',
        }

def info(message)
  LOGGER.info message
end

gems.each do |k, v|
  info "checking availability of #{k} in version #{v}"
  if Gem.cache.find_name(k, "=#{v}").empty? 
    info "gem not found, installing #{k} #{v}"
    info `gem install -v=#{v} #{k}`
  end
end
