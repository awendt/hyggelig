namespace :app do

  desc "Setup a development environment for hyggelig.org"
  task :setup do
    puts 'Generating session secret file...'
    system 'rake --silent secret:generate_file' unless File.exists?("#{RAILS.root}/config/session_key_secret")
    puts 'Copying database.yml...'
    system 'cp config/template.database.yml config/database.yml' unless File.exists?("#{RAILS.root}/config/database.yml")
    puts 'Installing RSpec framework...'
    system 'script/plugin install git://github.com/dchelimsky/rspec.git git://github.com/dchelimsky/rspec-rails.git'
    system 'script/generate rspec' unless File.exists?('script/spec')
  end

end