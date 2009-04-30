class AddExpiresOnToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :expires_on, :date
    Event.update_all ["expires_on = ?", Event::TIME_TO_LIVE.from_now.to_date]
  end

  def self.down
    remove_column :events, :expires_on
  end
end
