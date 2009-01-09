namespace :db do

  desc "Destroy expired events and associated responses"
  task :cleanup_events => :environment do
    Event.destroy_all(["created_at < ?", 60.days.ago])
  end

end

namespace :stats do

  desc "Show event stats"
  task :events => :environment do
    puts "Found #{Event.count} events with #{Response.count} responses"
  end

end

namespace :secret do

  desc "Generate config/session_key_secret if it does not exist"
  task :generate_file do
    session_key_sec_file = "#{RAILS_ROOT}/config/session_key_secret"
    if File.exists?(session_key_sec_file)
      puts "File #{session_key_sec_file} already exists. Nothing to do."
    else
      puts "Generating #{session_key_sec_file}... "
      exec "rake --silent secret > #{session_key_sec_file}"
    end
  end

end