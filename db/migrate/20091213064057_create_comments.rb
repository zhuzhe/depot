class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments ,:force=> true do |t|
      t.string :content
      t.references :product
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
