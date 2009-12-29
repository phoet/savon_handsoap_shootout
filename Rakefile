gems = {'savon' => '0.6.7', 'handsoap' => '1.1.4'}

task :install_gems do
  gems.each do |k, v|
    puts "checking gem #{k} in version #{v}"
    if Gem.cache.find_name(k, "=#{v}").empty? 
      puts "gem not found, installing #{k} #{v}"
      exec("gem install -v=#{v} #{k}") 
    end
  end
end