class CreateCarItems < ActiveRecord::Migration
  def self.up
    create_table :car_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :car_items
  end
end
