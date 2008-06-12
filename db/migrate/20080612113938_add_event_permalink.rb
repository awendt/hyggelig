class AddEventPermalink < ActiveRecord::Migration
  def self.up
    add_column(:events, :permalink, :string, :limit => 255)
  end

  def self.down
    remove_column(:events, :permalink)
  end
end
