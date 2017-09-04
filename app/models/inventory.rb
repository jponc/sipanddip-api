class Inventory < ApplicationRecord
  has_many :inventory_items, dependent: :destroy

  validates :slug, uniqueness: true, presence: true
end
