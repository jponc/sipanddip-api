class DailyRecord < ApplicationRecord
  has_many :inventory_items, dependent: :destroy

  validates :record_date, uniqueness: true, presence: true
  validates :gross_sales, :expenses, :deposit_amount, :food_cups_count,
            :drink_cups_count, presence: true

  def process_sales_data!
    DailyRecordServices::SalesData.new(self).process!
  end

  def process_inventory_data!
    DailyRecordServices::InventoryData.new(self).process!
  end
end
