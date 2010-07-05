class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars ,:force=> true do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :cars
  end
end
