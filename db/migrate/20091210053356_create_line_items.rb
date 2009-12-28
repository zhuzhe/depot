class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|

      t.integer :quantity,:nall=>false
      t.decimal :total_price,:null=>false,:precision=>8,:scale=>2

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
