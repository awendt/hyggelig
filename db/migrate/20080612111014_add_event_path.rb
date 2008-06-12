class AddEventPath < ActiveRecord::Migration
  def self.up
    add_column :events, :path, :string, :limit => 255
  end

  def self.down
    remove_column :events, :path
  end
end
