class FixAssociationInventoryItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :inventory_items, :inventory, foreign_key: true, index: true
    add_reference :inventory_items, :daily_record, foreign_key: true, index: true
  end
end
