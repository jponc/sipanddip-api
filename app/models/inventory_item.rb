class InventoryItem < ApplicationRecord
  belongs_to :daily_record
  belongs_to :inventory

  validates :in_count, :out_count, :total_count, presence: true
end
