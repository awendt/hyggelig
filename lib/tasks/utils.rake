namespace :db do

  desc "Destroy expired events and associated responses"
  task :cleanup_events => :environment do
    Event.destroy_all(["created_at < ?", 60.days.ago])
  end

end
