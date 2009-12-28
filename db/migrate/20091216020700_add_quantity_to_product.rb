class AddQuantityToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :quantity, :integer
  end

  def self.down
    remove_column :products, :quantity
  end
end
