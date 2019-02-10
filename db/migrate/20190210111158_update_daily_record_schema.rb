class UpdateDailyRecordSchema < ActiveRecord::Migration[5.1]
  def change
    remove_column :daily_records, :food_cups_count
    remove_column :daily_records, :drink_cups_count
    remove_column :daily_records, :pwd_count
    remove_column :daily_records, :discount_count
    remove_column :daily_records, :mojos_count

    add_column :daily_records, :combo_cups_count, :integer, default: 0
    add_column :daily_records, :combo_cups_dc_count, :integer, default: 0
    add_column :daily_records, :sides_count, :integer, default: 0
    add_column :daily_records, :sides_dc_count, :integer, default: 0
    add_column :daily_records, :drinks_count, :integer, default: 0
    add_column :daily_records, :drinks_dc_count, :integer, default: 0
    add_column :daily_records, :dips_count, :integer, default: 0
    add_column :daily_records, :dips_dc_count, :integer, default: 0
  end
end
