class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table(:responses, :id => false) do |t|
      t.references :event, :null => false
      t.string :name,      :null => false, :limit => 255
      t.boolean :rsvp,     :null => false

      t.timestamps
    end

    add_index :responses, [:event_id, :name], :unique => true
  end

  def self.down
    remove_index :responses, :column => [:event_id, :name]
    drop_table :responses
  end
end
