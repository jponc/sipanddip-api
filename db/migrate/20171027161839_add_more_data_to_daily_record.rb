class AddMoreDataToDailyRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_records, :discrepancy, :decimal, precision: 7, scale: 2
    add_column :daily_records, :notes, :text
  end
end
