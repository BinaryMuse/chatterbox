class AddHashToRoom < ActiveRecord::Migration
  class Room < ActiveRecord::Base; end

  def self.up
    add_column :rooms, :hash, :string
    Room.reset_column_information
    Room.all.each { |r| r.hash = Digest::SHA1.hexdigest(r.name); r.save! }
  end

  def self.down
    remove_column :rooms, :hash
  end
end
