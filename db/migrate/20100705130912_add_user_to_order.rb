class AddUserToOrder < ActiveRecord::Migration
  def self.up
        add_column :orders, :user_id, :string
  end

  def self.down
        remove_column :orders, :user_id
  end
end
