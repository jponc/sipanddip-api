class ModifyDiscrepancyDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :daily_records, :discrepancy, :decimal, precision: 7, scale: 2, default: 0
  end
end
