class AddHashToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :hash, :string
  end

  def self.down
    remove_column :rooms, :hash
  end
end
