class DailyRecord < ApplicationRecord
  has_many :inventory_items, dependent: :destroy

  validates :record_date, uniqueness: true, presence: true
  validates :gross_sales, :expenses, :deposit_amount, :food_cups_count,
            :drink_cups_count, presence: true

  %i(gross_sales expenses deposit_amount discrepancy).each do |attr|
    define_method "format_#{attr}" do
      amount_in_cents = self.send(attr) * 100
      Money.new(amount_in_cents, 'PHP').format
    end
  end

  def process_reports!
    process_sales_data!
    process_inventory_data!
    # send_to_fb!
  end

  def process_sales_data!
    DailyRecordServices::SalesData.new(self).process!
  end

  def process_inventory_data!
    DailyRecordServices::InventoryData.new(self).process!
  end

  def send_to_fb!
    DailyRecordServices::SendToFb.new(self).process!
  end
end
