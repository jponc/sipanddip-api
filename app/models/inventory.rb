class Inventory < ApplicationRecord
  validates :slug, uniqueness: true, presence: true
end
