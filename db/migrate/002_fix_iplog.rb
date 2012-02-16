class FixIplog < ActiveRecord::Migration
  def self.up
    rename_column :iplog, :disallow, :suck_id
    remove_column :iplog, :timestamp
  end

  def self.down
    rename_column :iplog, :suck_id, :disallow
    add_column    :iplog, :timestamp , :datetime
  end
end
