class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name,     :null => false, :limit => 255
      t.string :date,     :null => false, :limit => 255
      t.string :location, :null => false, :limit => 255

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
