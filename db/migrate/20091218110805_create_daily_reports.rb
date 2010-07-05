class CreateDailyReports < ActiveRecord::Migration
  def self.up
    create_table :daily_reports ,:force=> true do |t|
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :daily_reports
  end
end
