class AddIncomeToDailyReport < ActiveRecord::Migration
  def self.up
    add_column :daily_reports,:income,:decimal,:precision=>10,:scale=>2
  end

  def self.down
    remove_column :daily_reports,:income
  end
end
