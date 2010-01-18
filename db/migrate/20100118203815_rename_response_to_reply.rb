class RenameResponseToReply < ActiveRecord::Migration
  def self.up
    rename_table('responses', 'replies')
  end

  def self.down
    rename_table('replies', 'responses')
  end
end
