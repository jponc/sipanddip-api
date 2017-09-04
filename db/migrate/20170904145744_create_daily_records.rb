class CreateDailyRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_records do |t|
      t.date :record_date, index: true, null: false
      t.decimal :gross_sales, default: 0.0, precision: 7, scale: 2
      t.decimal :expenses, default: 0.0, precision: 7, scale: 2
      t.decimal :deposit_amount, default: 0.0, precision: 7, scale: 2
      t.integer :food_cups_count, default: 0
      t.integer :drink_cups_count, default: 0
      t.string :prepared_by

      t.timestamps
    end
  end
end
