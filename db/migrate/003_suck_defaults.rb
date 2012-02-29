class SuckDefaults< ActiveRecord::Migration
  def self.up
    change_column :suck, :points, :integer, :default => 0
    change_column :suck, :stagnation, :integer, :default => 0
  end

  def self.down
    change_column :suck, :points, :integer, :default => nil
    change_column :suck, :stagnation, :integer, :default => nil
  end
end
