class RenameSuck< ActiveRecord::Migration
  def self.up
    rename_table :suck, :suck_items
  end

  def self.down
    rename_table :suck_items, :suck
  end
end
