class CreateSuck < ActiveRecord::Migration
  def self.up
    create_table :suck do |t|
      t.string :name
      t.integer :points
      t.integer :stagnation
      t.timestamps
    end

    create_table :iplog do |t|
      t.integer :disallow
      t.string :ip
      t.datetime :timestamp
      t.string :flag
      t.timestamps
    end
  end

  def self.down
    drop_table :suck
    drop_table :iplog
  end
end
