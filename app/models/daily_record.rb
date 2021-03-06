class DailyRecord < ApplicationRecord
  has_many :inventory_items, dependent: :destroy

  validates :record_date, uniqueness: true, presence: true
  validates :gross_sales,
            :expenses,
            :combo_cups_count,
            :combo_cups_dc_count,
            :sides_count,
            :sides_dc_count,
            :drinks_count,
            :drinks_dc_count,
            :deposit_amount,
            :discrepancy, presence: true

  %i(gross_sales expenses deposit_amount discrepancy).each do |attr|
    define_method "format_#{attr}" do
      amount_in_cents = self.send(attr) * 100
      Money.new(amount_in_cents, 'PHP').format
    end
  end

  def process_reports!
    process_sales_data!
    process_inventory_data!
  end

  def process_sales_data!
    DailyRecordServices::SalesData.new(self).process!
  end

  def process_inventory_data!
    DailyRecordServices::InventoryData.new(self).process!
  end
end
