class DailyRecord < ApplicationRecord
  validates :record_date, uniqueness: true, presence: true
  validates :gross_sales, presence: true
  validates :expenses, presence: true
  validates :deposit_amount, presence: true
  validates :food_cups_count, presence: true
  validates :drink_cups_count, presence: true
end
