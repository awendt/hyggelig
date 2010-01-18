desc "Cron job for Heroku"
task :cron => :environment do
  Event.expired.destroy_all
  puts "#{Date.today.to_s(:iso)};#{Event.count};#{Reply.count}"
end
