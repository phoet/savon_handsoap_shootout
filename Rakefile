include FileUtils

gems = {'savon' => '0.6.7', 'handsoap' => '1.1.4', 'RedCloth' => '4.2.2'}

desc 'installs all the gems'
task :install_gems do
  gems.each do |k, v|
    puts "checking gem #{k} in version #{v}"
    if Gem.cache.find_name(k, "=#{v}").empty? 
      puts "gem not found, installing #{k} #{v}"
      exec("gem install -v=#{v} #{k}") 
    end
    require k
  end
end

desc 'creates the documentation'
task :create_doc => :install_gems do
  Dir.mkdir('_site') unless File.exists?('_site')
  Dir.glob('*.textile').each do |file|
    text = File.readlines(file)
    html = RedCloth.new(text.join).to_html
    fname = File.basename(file, '.textile')
    File.open("_site/#{fname}.html",'w'){|f| f.write(html) }
  end
end

desc 'cleans the project'
task :clean do
  FileUtils.rm_rf('_site') if File.exists?('_site')
end

desc 'the default task'
task :default do
  Rake::Task[:create_doc].invoke 
end