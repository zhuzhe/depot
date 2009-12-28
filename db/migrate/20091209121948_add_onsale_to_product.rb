class AddOnsaleToProduct < ActiveRecord::Migration
  def self.up
    add_column :products ,:onsale,:boolean,:default=>false
  end

  def self.down
    remove_column :products, :onsale
  end
end
