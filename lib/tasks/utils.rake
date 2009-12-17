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