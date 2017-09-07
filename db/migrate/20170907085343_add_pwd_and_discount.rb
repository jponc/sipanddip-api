class AddPwdAndDiscount < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_records, :pwd_count, :integer, default: 0
    add_column :daily_records, :discount_count, :integer, default: 0
  end
end
