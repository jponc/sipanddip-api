class Inventory < ApplicationRecord
  validates :slug, uniqueness: true
end
