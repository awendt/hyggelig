class AddIdToResponse < ActiveRecord::Migration
  def self.up
    add_column :responses, :id, :primary_key
  end

  def self.down
    remove_column :responses, :id
  end
end
