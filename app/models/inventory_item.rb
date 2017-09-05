class InventoryItem < ApplicationRecord
  belongs_to :daily_record
  belongs_to :inventory

  validates :in_count, :out_count, :total_count, presence: true

  scope :with_changes, -> { where('in_count != ? OR out_count != ?', 0, 0) }
  scope :restock_needed, -> {
    joins(:inventory).where('inventory_items.total_count <= inventories.restock_trigger_count')
  }

  def any_changes?
    (in_count != 0) || (out_count != 0)
  end
end
