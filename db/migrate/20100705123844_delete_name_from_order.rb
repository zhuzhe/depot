class DeleteNameFromOrder < ActiveRecord::Migration
  def self.up
      remove_column :orders, :name
  end

  def self.down
        add_column :orders, :name, :string
  end
end
