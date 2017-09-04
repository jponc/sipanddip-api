class DailyRecord < ApplicationRecord
  has_many :inventory_items, dependent: :destroy

  validates :record_date, uniqueness: true, presence: true
  validates :gross_sales, :expenses, :deposit_amount, :food_cups_count,
            :drink_cups_count, presence: true
end
